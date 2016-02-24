/**
 * 
 */
//package edu.usc.fall2010.cs599.cfg;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import org.apache.bcel.Constants;
import org.apache.bcel.classfile.ClassParser;
import org.apache.bcel.classfile.JavaClass;
import org.apache.bcel.generic.ConstantPoolGen;
import org.apache.bcel.classfile.Method;
import org.apache.bcel.generic.BranchHandle;
import org.apache.bcel.generic.GotoInstruction;
import org.apache.bcel.generic.IfInstruction;
import org.apache.bcel.generic.Select;
import org.apache.bcel.generic.InvokeInstruction;
import org.apache.bcel.generic.InstructionHandle;
import org.apache.bcel.generic.InstructionList;

public class CFG {
	// Static Dotty file strings.
	protected static final String[] dottyFileHeader = new String[] {
		"digraph control_flow_graph {",
		"",
		"	node [shape = rectangle]; entry exit;",
		"	node [shape = circle];",
		""
	};
	protected static final String[] dottyFileFooter = new String[] {
		"}"
	};
	protected static final String dottyEntryNode = "entry";
	protected static final String dottyExitNode = "exit";
	// Dotty file edge templates.
	protected static final String dottyLineFormat = "	%1$s -> %2$s;%n";
	protected static final String dottyLineLabelFormat = "	%1$s -> %2$s [label = \"%3$s\"];%n";

	// Map associating line number with instruction.
	SortedMap<Integer, InstructionHandle> statements = new TreeMap<Integer, InstructionHandle>();
	InstructionHandle first, last;
	int size;
	int [][] reacable;//store statment combination for further used in reachability
	/**
	 * Loads an instruction list and creates a new CFG.
	 * 
	 * @param instructions Instruction list from the method to create the CFG from.
	 */
	public CFG( InstructionList instructions ) {
		InstructionHandle ihslist[] = instructions.getInstructionHandles();
		for (InstructionHandle ih : ihslist) {
			statements.put(ih.getPosition(),ih);
		}
		first = instructions.getStart();
		last = instructions.getEnd();
		size = instructions.getLength();
		int end = ihslist[size-1].getPosition();
		reacable = new int[end+1][end+1];
	}
	/**
	 * Generates a Dotty file representing the CFG.
	 * 
	 * @param out OutputStream to write the dotty file to.
	 */
	public void generateDotty( OutputStream _out ) {
		PrintStream printer = new PrintStream(_out);
		for (String head : dottyFileHeader) {
			printer.println(head);
		}
		printer.printf(dottyLineFormat, dottyEntryNode, first.getPosition());
		for (InstructionHandle instructlist: statements.values()) {
			if (instructlist.getNext() != null) {
				if (instructlist instanceof BranchHandle) {
					BranchHandle branch = (BranchHandle) instructlist;
					if (branch.getInstruction() instanceof GotoInstruction) {
						printer.printf(dottyLineFormat, branch.getPosition(), branch.getTarget().getPosition());
					}
					else if (branch.getInstruction() instanceof IfInstruction) {
						IfInstruction ifBranch = (IfInstruction) branch.getInstruction();
						printer.printf(dottyLineLabelFormat,branch.getPosition(), branch.getTarget().getPosition(),ifBranch.getName());
						printer.printf(dottyLineLabelFormat,branch.getPosition(), branch.getNext().getPosition(),ifBranch.negate().getName());
					}
					else if (branch.getInstruction() instanceof Select) {
						Select selectBranch = (Select) branch.getInstruction();
						for (int i = 0; i < selectBranch.getMatchs().length; i ++) {
							printer.printf(dottyLineLabelFormat,branch.getPosition(), selectBranch.getTargets()[i].getPosition(),selectBranch.getMatchs()[i]);
						}
					}
				}
				else {
					printer.printf(dottyLineFormat, instructlist.getPosition(), instructlist.getNext().getPosition());
				}
			}
		}
		printer.printf(dottyLineFormat, last.getPosition(), dottyExitNode);
		for (String s : dottyFileFooter) {
			printer.println(s);
		}
	}
	
	//generate the rechability
	public void generateReachability() {
		for (int i = 0; i < reacable.length; i++) {
			for (int j = 0; j < reacable.length; j++) {
				if (i == j){
					reacable[i][j] = 0; 
				}
				else{
					reacable[i][j] = 1000000; 
				}
			}
		}
		
		for (int i = 0; i < reacable.length; i++) {
			if (!statements.containsKey(i)) {
				continue;
			}
			InstructionHandle instructlist = statements.get(i);
			if (instructlist.getNext() != null) {
				if (instructlist instanceof BranchHandle) {
					BranchHandle bran = (BranchHandle) instructlist;
					if (bran.getInstruction() instanceof GotoInstruction) {
						reacable[bran.getPosition()][bran.getTarget().getPosition()] = 1;
					}
					if (bran.getInstruction() instanceof IfInstruction) {
						reacable[bran.getPosition()][bran.getTarget().getPosition()] = 1;
						reacable[bran.getPosition()][bran.getNext().getPosition()] = 1;
					}
					if (bran.getInstruction() instanceof Select) {
						Select selbran = (Select) bran.getInstruction();
						for (int j = 0; j < selbran.getMatchs().length; j ++) {
							reacable[bran.getPosition()][selbran.getTargets()[j].getPosition()] = 1;
						}
					}
				}
				else {
					reacable[instructlist.getPosition()][instructlist.getNext().getPosition()] = 1;
				}
			}
		}
		// Floyd-Warshall
		for (int k = 0; k < reacable.length; k++) {
			for (int i = 0; i < reacable.length; i++) {
				for (int j = 0; j < reacable.length; j++) {
					if (reacable[i][j] > reacable[i][k] + reacable[k][j]) {
						reacable[i][j] = reacable[i][k] + reacable[k][j];
					}
				}
			}
		}
	}

	//judge whether node invoke1 can reach node invoke2
	public boolean search(int reacable[][], ConstantPoolGen cpg, String invoke1, String invoke2){
		List<Integer> listOne = new ArrayList<Integer>();
		List<Integer> listTwo = new ArrayList<Integer>();
		for(InstructionHandle instructlist : statements.values()){
			if(instructlist.getInstruction() instanceof InvokeInstruction){
				InvokeInstruction invoke = (InvokeInstruction) instructlist.getInstruction();
				if(invoke1.equals(invoke.getMethodName(cpg))){
					listOne.add(Integer.valueOf(instructlist.getPosition()));
				}
				if(invoke2.equals(invoke.getMethodName(cpg))){
					listTwo.add(Integer.valueOf(instructlist.getPosition()));
				}
			}
		}
		int[] listOne_array = new int[listOne.size()];
		int[] listTwo_array = new int[listTwo.size()];
		for (int i= 0; i< listOne.size(); i++){
			listOne_array[i] = listOne.get(i).intValue();
		}
		for (int j = 0; j < listTwo.size(); j++){
			listTwo_array[j] = listTwo.get(j).intValue();
		}
		boolean reachability = false;
		for(int i:listOne_array){
			for(int j:listTwo_array){
				if(reacable[i][j] < 1000000 && i != j){
					reachability=true;
				}
			}
		}
		return reachability;
	}
	//judge whether one node can reach itself
	public boolean searchitself(int reacable[][], ConstantPoolGen cpg, String name){
		List<Integer> result = new ArrayList<Integer>();
		for(InstructionHandle instructlist : statements.values()){
			if(instructlist.getInstruction() instanceof InvokeInstruction){
				InvokeInstruction invoke = (InvokeInstruction) instructlist.getInstruction();
				if(name.equals(invoke.getMethodName(cpg))){
					result.add(Integer.valueOf(instructlist.getPosition()));
				}
			}
		}
		int[] result_array = new int[result.size()];
		for (int i = 0; i < result.size(); i++){
			result_array[i] = result.get(i).intValue();
		}
		boolean reachability = false;
		for(int i:result_array){
			for (int j:result_array) {
				if(reacable[i][j] < 1000000 && reacable[i][j] >= 1 && i == j){
					reachability = true;
				}
			}
		}
		return reachability;
	}

	/**
	 * Main method. Generate a Dotty file with the CFG representing a given class file.
	 * 
	 * @param args Expects two arguments: <input-class-file> <output-dotty-file>
	 */
	public static void main(String[] args) {
		PrintStream error = System.err;
		PrintStream debug = System.out;

		// Check arguments number should be 3: inputfile,output_dottyfile,output_reachability
		if ( args.length != 2) {
			error.println( "Wrong number of arguments." );
			error.println( "Usage: CFG <input-class-file> <output-dotty-file>" );
			System.exit( 1 );
		}
		String inputClassFilename = args[0];
		String outputDottyFilename = args[1];

		// Parse class file.
		debug.println( "Parsing " + inputClassFilename + "." );
		JavaClass cls = null;
		try {
			cls = (new ClassParser( inputClassFilename )).parse();
		} catch (IOException e) {
			e.printStackTrace( debug );
			error.println( "Error while parsing " + inputClassFilename + "." );
			System.exit( 1 );
		}

		// Search for main method.
		debug.println( "Searching for main method:" );
		Method mainMethod = null;
		for ( Method m : cls.getMethods() ) {
			debug.println( "   " + m.getName() );
			if ( "main".equals( m.getName() ) ) {
				mainMethod = m;
				break;
			}
		}
		if ( mainMethod == null ) {
			error.println( "No main method found in " + inputClassFilename + "." );
			System.exit( 1 );
		}

		// Create CFG.
		debug.println( "Creating CFG object." );
		CFG cfg = new CFG( new InstructionList( mainMethod.getCode().getCode() ) );
		
		// Output Dotty file.
		debug.println( "Generating Dotty file." );
		try {
			OutputStream output = new FileOutputStream( outputDottyFilename );
			cfg.generateDotty( output );
			output.close();
		} catch (IOException e) {
			e.printStackTrace( debug );
			error.println( "Error while writing to " + outputDottyFilename + "." );
			System.exit( 1 );
		}

		// Get Reachability
		cfg.generateReachability();


		//Present the Reachability
		ConstantPoolGen cpg = new ConstantPoolGen(cls.getConstantPool());
		Scanner sc = new Scanner(System.in);
		String inputOne = sc.next();
		String inputTwo = sc.next();
		boolean result = cfg.search(cfg.reacable,cpg,inputOne,inputTwo); 
		boolean resultItself = cfg.searchitself(cfg.reacable,cpg,inputOne);
		if(inputOne.equals(inputTwo)){
			if(result == true){
				System.out.println(inputOne + " can reach " + inputTwo);
			} else {
				System.out.println(inputOne + " can reach " + inputTwo);
			}
			if(resultItself == true){
				System.out.println(inputOne + " can reach itself");
			} else{
				System.out.println(inputOne + " cannot reach itself");
			}
		} else {
			if(result == true){
				System.out.println(inputOne + " can reach " + inputTwo);
			} else{
				System.out.println(inputOne + " cannot reach " + inputTwo);
			}
		}
		
		debug.println( "Done." );
	}
}

