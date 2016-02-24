import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import org.apache.bcel.Constants;
import org.apache.bcel.classfile.ClassFormatException;
import org.apache.bcel.classfile.ClassParser;
import org.apache.bcel.classfile.JavaClass;
import org.apache.bcel.classfile.LineNumber;
import org.apache.bcel.classfile.LineNumberTable;
import org.apache.bcel.generic.ConstantPoolGen;
import org.apache.bcel.classfile.Method;
import org.apache.bcel.generic.BranchHandle;
import org.apache.bcel.generic.GotoInstruction;
import org.apache.bcel.generic.IfInstruction;
import org.apache.bcel.generic.Select;
import org.apache.bcel.generic.InvokeInstruction;
import org.apache.bcel.generic.InstructionHandle;
import org.apache.bcel.generic.InstructionList;

public class myDejaVu {

	private static final boolean DEBUG = true;
	//DejaVu, compare two CFG to get the fault suspicious edge(dangeous)
	public Edge myDejaVu(List<Edge> orgCfg, List<Edge> fauCfg) {
		int i = 0 ;
		for(i=0; i < orgCfg.size(); i++) {
			if(!orgCfg.get(i).equals(fauCfg.get(i)) && i!=2) {
				break;
			}
		}
		
		
		//System.out.println(orgCfg.get(i).toString());

		return fauCfg.get(i);
	}
	
	//get the source line of the dangerous edge
	public String getDangerEdgeSourceLine(String orgJava, String fauJava, String method) {
		
		int sourceline = 0;
		JavaClass orgCls = null;
		JavaClass fauCls = null;

		try {
			orgCls = (new ClassParser(orgJava)).parse();
			fauCls = (new ClassParser(fauJava)).parse();

		} catch (ClassFormatException | IOException e) {
				// TODO Auto-generated catch block
			e.printStackTrace();
			System.exit( 1 );
		}
		

		CFG orgCfg = new CFG(orgCls, method) ;
		CFG fauCfg = new CFG(fauCls, method);
		
		List<Edge> orgCfgList = orgCfg.getCFGList();
		List<Edge> fauCfgList = fauCfg.getCFGList();
	
		Edge dangerEdge = this.myDejaVu(orgCfgList, fauCfgList);
		
		sourceline = fauCfg.getSourceLineNumber(dangerEdge.startPosition);
		return String.valueOf(sourceline);
	}
				
	public static void main(String[] args) {
		
		myDejaVu myDejaVu = new myDejaVu();
		//@SuppressWarnings("resource")
		
		FileReader myInput = null;
		FileWriter myOutput = null;
		FileWriter myOutput1 = null;
		try {
			myInput = new FileReader("/home/student/ICAClinic/ICA9/class_files.txt");
			myOutput = new FileWriter("/home/student/ICAClinic/ICA9/faultEdges.txt");
			myOutput1 = new FileWriter("/home/student/ICAClinic/ICA9/fault_analysis.txt");
			
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		Scanner inputStr = new Scanner(myInput);
		
		while(inputStr.hasNext()) {
			long start = System.currentTimeMillis();
			String[] ClassFile= inputStr.next().split("-");
			String result = ClassFile[0] + " " + ClassFile[2] + " " + myDejaVu.getDangerEdgeSourceLine(ClassFile[0], ClassFile[1], ClassFile[2]);
			long end = System.currentTimeMillis();
			
			float seconds = (end-start)/1000F;
			
			try {	
				myOutput1.write(seconds+"\n");
				myOutput.write(result + "\n");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		try {
			myOutput1.close();
			myOutput.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}	
}
class Edge {
	
	int startPosition;
	int targetPosition; 
	boolean visited;
	
	String lable;
	String startCount;
	String targetCount;
	
	public void setlable(String _lable) {
		this.lable = _lable;
	}
	
	public void setstartCount(String _startCount) {
		this.startCount = _startCount;
	}
	public void settargetCount(String _targetCount) {
		this.targetCount = _targetCount;
	}
	
	Edge (int _startPosition, String _startCount, int _targetPosition, String _targetCount) {
		this.startPosition = _startPosition;
		this.targetPosition = _targetPosition;
		this.startCount = _startCount;
		this.targetCount = _targetCount;
		
		this.lable = "";
		this.visited = false;
	}
	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append(" " +this.startCount + "  -->   ");
		sb.append(" " + this.targetCount);
		return sb.toString();
	}
	
	public boolean equals(Edge e) {
		if(this.startCount.equals(e.startCount) && this.targetCount.equals(e.targetCount) 
				&& this.lable.equals(e.lable)) {
			return true;
		}
		return false;
	}
	
}


class CFG {
	
	private static final boolean DEBUG = true;
	
	private SortedMap<Integer, InstructionHandle> statements = new TreeMap<Integer, InstructionHandle>();
	private Map<Integer, Integer> lineNumberMap = new HashMap<Integer, Integer>();
	private List<Edge> cfg = new ArrayList<Edge>();
	
	public CFG (JavaClass cls, String faultMethodName) {
		
		Method faultMethod = findMainMethod(cls,faultMethodName);

		if ( faultMethodName == null ) {
				System.out.println( "No fault method found ");
				System.exit( 1 );
		}
		InstructionList instructions = new InstructionList(faultMethod.getCode().getCode());	
		InstructionHandle ihslist[] = instructions.getInstructionHandles();
		
		for (InstructionHandle ih : ihslist) {
			statements.put(ih.getPosition(),ih);
		}
		
		LineNumberTable lnt = faultMethod.getCode().getLineNumberTable();
		LineNumber[] lineNums = lnt.getLineNumberTable();
		
		for(LineNumber ln : lineNums) {
			lineNumberMap.put(ln.getStartPC(), ln.getLineNumber());
		}
		
		generateCFGList();
	}
	
	public List<Edge> getCFGList() {
		return cfg;
	}
	
	public int getSourceLineNumber(int offset) {
		//System.out.println(offset);
		while(!lineNumberMap.containsKey(offset)) {
			offset--;
		}
		return lineNumberMap.get(offset);
	}
	
	private void generateCFGList() {
		
		for (InstructionHandle instructlist: statements.values()) {
			
			if (instructlist.getNext() != null) {
				
				if (instructlist instanceof BranchHandle) {
					
					BranchHandle bran = (BranchHandle) instructlist;
					if (bran.getInstruction() instanceof GotoInstruction) {
						Edge edge = new Edge(bran.getPosition(), bran.toString(true).substring(6), 
							bran.getTarget().getPosition(), bran.getTarget().toString(true).substring(6));
						cfg.add(edge);
					
					}
					else if (bran.getInstruction() instanceof IfInstruction) {
						IfInstruction ifbran = (IfInstruction) bran.getInstruction();
						Edge edge1 = new Edge(bran.getPosition(), bran.toString(true).substring(6), 
								bran.getTarget().getPosition(), bran.getTarget().toString(true).substring(6));
						edge1.lable = ifbran.getName();
						cfg.add(edge1);
						Edge edge2 = new Edge(bran.getPosition(), bran.toString(true).substring(6), 
								bran.getNext().getPosition(), bran.getNext().toString(true).substring(6));
						edge2.lable = ifbran.negate().getName();
						cfg.add(edge2);
					}
					
					else if (bran.getInstruction() instanceof Select) {
						Select selbran = (Select) bran.getInstruction();
						for (int i = 0; i < selbran.getMatchs().length; i ++) {
							Edge edge = new Edge(bran.getPosition(), bran.toString(true).substring(6), 
									selbran.getTargets()[i].getPosition(), selbran.getTargets()[i].toString(true).substring(6));
							cfg.add(edge);
						}
					}
					
				}
				else {
					
					Edge edge = new Edge(instructlist.getPosition(), instructlist.toString(true).substring(6), 
							instructlist.getNext().getPosition(), instructlist.getNext().toString(true).substring(6));
					cfg.add(edge);
					
				}
			}	
		}		
	}
	
	
	private Method findMainMethod(JavaClass cls, String faultMethod) {
		Method mainMethod = null;
		for ( Method m : cls.getMethods() ) {
			if (faultMethod.equals( m.getName() ) ) {
				mainMethod = m;
				return mainMethod;
			}
		}
		return null;
	}
	
}





