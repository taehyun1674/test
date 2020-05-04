package egovframework.nia.spdMsr.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.Reader;
import java.io.StringReader;
import java.security.MessageDigest;
import java.util.UUID;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

@SuppressWarnings("restriction")
public class Utility {
	public static final String ENCODE_TYPE = "EUC-KR";
	public static final String ENCODE_TYPE_UTF8 = "UTF-8";
	  
	public static String getSHA256(String password) {
		try {

			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(password.getBytes());

			byte byteData[] = md.digest();

			// convert the byte to hex format method 1
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16)
						.substring(1));
			}

			// convert the byte to hex format method 2
			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				String hex = Integer.toHexString(0xff & byteData[i]);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}
			return hexString.toString();
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}
	
	/**
	  * @param _source
	  * @param _key
	  * @return
	  * @throws Exception
	  */
	public static String encode(String _source, String _key) throws Exception {
		if (_source == null) return "";

	    BASE64Encoder encoder = new BASE64Encoder();

	    byte[] srcBuf = _source.getBytes(ENCODE_TYPE_UTF8);
	    byte[] encBuf = new byte[srcBuf.length];
	    byte[] keyBuf = _key.getBytes(ENCODE_TYPE_UTF8);

	    int idxKey = 0;

	    for (int i = 0; i < srcBuf.length; i++) {
	      if (idxKey == keyBuf.length) idxKey = 0;
	      encBuf[i] = (byte) (srcBuf[i] ^ keyBuf[idxKey]);
	      idxKey++;
	    }

	   return encoder.encode(encBuf);
	}
	
	/**
	 * @param _source
	 * @param _key
	 * @return
	 * @throws Exception
	 */
	public static String decode(String _source, String _key) throws Exception {
	  if (Utility.CheckNull(_source).equals("")) return "";
	  
	  BASE64Decoder decoder = new BASE64Decoder();
	  byte[] srcBuf = decoder.decodeBuffer(_source);
	  byte[] keyBuf = _key.getBytes(ENCODE_TYPE_UTF8);
	  byte[] decBuf = new byte[srcBuf.length];
	
	  int idxKey = 0;
	
	  for (int i = 0; i < srcBuf.length; i++) {
	    if (idxKey == keyBuf.length) idxKey = 0;
	    decBuf[i] = (byte) (srcBuf[i] ^ keyBuf[idxKey]);
	
	    idxKey++;
	  }
	  return new String(decBuf, ENCODE_TYPE_UTF8);
	}
	
	/**
	 * String check NULL
	 * @param str
	 * @return
	 */
	public static String CheckNull(String str){
		if(str != null){
			return str;
		}
		else{
			return "";
		}
	}
	
	/**
	조회나, 수정form에 뿌려 줄때 값이 null이면 화면에 null이라고 찍히는 것을 없애기 위해사용한다
	*/
	public static String NVL(Object obj){
		if(obj != null) return obj.toString().trim();
		else return "";
	}
	
	
	/**
	 * 파일 형식 체크
	 * @param FilePath
	 * @return
	 */
	public static String CheckFileName(String FileName){
		String CheckFileName = FileName;
		
		CheckFileName = ReplaceAll(CheckFileName, "..", ".");
		CheckFileName = ReplaceAll(CheckFileName, "//", "/");
		CheckFileName = ReplaceAll(CheckFileName, "\\", "/");
		
		return CheckFileName;
	}
	
	/**
	 * 파일 존재 여부 체크
	 * @param FilePath
	 * @return
	 */
	public static boolean CheckFile(String FilePath){
		boolean result = false;
		
		try{
			FilePath = CheckFileName(FilePath);
			
			File file = new File(FilePath);
			
			result = file.exists();
		}catch(Exception e){
			result = false;
		}
		
		return result;
	}

	/**
	 * @return formatted string representation of current day with "yyyyMMdd".
	 */
	public static String getShortDateString()
	{
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd", java.util.Locale.KOREA);
		
		return formatter.format(new java.util.Date());
	}
	
	/** 2017-12-11 : 추가
	 * @return formatted string representation of current time with "HHmmss".
	 */
	public static String getShortTimeString()
	{
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("HHmmss", java.util.Locale.KOREA);
		
		return formatter.format(new java.util.Date());
	}
	
	
	/**
	 * @return formatted string representation of current time with "yyyy-MM-dd-HH:mm:ss".
	 */
	public static String getTimeStampString() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SSS", java.util.Locale.KOREA);
		return formatter.format(new java.util.Date());
	}
	
	
	/**
	 * @param format
	 * @param days
	 * @return format string representation of the date format. For example, "yyyy-MM-dd".
	 */
	public static String getFormatDateString(String format, int days){
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.KOREA);
		java.util.Date date = new java.util.Date();
		date.setTime(date.getTime() + ((long)days * 1000 * 60 * 60 * 24));
		
		return formatter.format(date);
	}
	
	
	/**
	 * @param format
	 * @param days
	 * @return format string representation of the date format. For example, "yyyy-MM-dd".
	 */
	public static java.util.Date getFormatDate(String format, String DateStr){
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.KOREA);
		java.util.Date date = null;
		try{
			date = formatter.parse(DateStr);
		}catch(Exception e){
			date = new java.util.Date();
		}
		
		return date;
	}
	
	
	/**
	 * return times between two date strings with default defined format.
	 * @param format
	 * @param from
	 * @param to
	 * @return
	 */
	public static long timesBetween(String format, String from, String to){
		java.util.Date d1 = getFormatDate(format, from);
		java.util.Date d2 = getFormatDate(format, to);

		long duration = d2.getTime() - d1.getTime();

		return duration;
	}

	
	/**
	 * 입력받은 String을 원하는 길이만큼 원하는 문자로 오른쪽을 채워주는 함수
	 * @param SourceStr
	 * @param StrLen
	 * @param PadChar
	 * @return
	 */
	public static String RPAD(String SourceStr, int StrLen, char PadChar){
		String PaddingStr = SourceStr;
		int PadCnt = 0;
		
		if(SourceStr == null || SourceStr.length() == 0){
			PaddingStr = "";
			PadCnt = StrLen;
		}
		else{
			char[] TempStr = SourceStr.toCharArray();
			
			int StrByteSize = 0;
			int CharSize = 0;
			
			for(int idx = 0; idx < TempStr.length; idx++){
				if(TempStr[idx] < 256){
					CharSize = 1;
				}
				else{
					CharSize = 2;
				}
				
				if(StrByteSize + CharSize > StrLen){
					PaddingStr = SourceStr.substring(0, idx);
					break;
				}
				else{
					StrByteSize += CharSize;
				}
			}
			
			PadCnt = StrLen - StrByteSize;
		}
		
		for(int idx = 0; idx < PadCnt; idx++){
			PaddingStr = PaddingStr + PadChar;
		}

		return PaddingStr;
	}
	
	public static String RPAD(int SourceStr, int StrLen, char PadChar){
		String result = RPAD(Integer.toString(SourceStr), StrLen, PadChar);
		
		return result;
	}
	
	public static String RPAD(long SourceStr, int StrLen, char PadChar){
		String result = RPAD(Long.toString(SourceStr), StrLen, PadChar);
		
		return result;
	}

	
	/**
	 * 입력받은 String을 원하는 길이만큼 원하는 문자로 왼쪽을 채워주는 함수
	 * @param SourceStr
	 * @param StrLen
	 * @param PadChar
	 * @return
	 */
	public static String LPAD(String SourceStr, int StrLen, char PadChar) 
	{
		String PaddingStr = SourceStr;
		int PadCnt = 0;
		
		if (SourceStr == null || SourceStr.length() == 0) {
			PaddingStr = "";
			PadCnt = StrLen;
		}
		else {
			char[] TempStr = SourceStr.toCharArray();
			
			int StrByteSize = 0;
			int CharSize = 0;
			
			for (int idx = 0; idx < TempStr.length; idx++) {
				if (TempStr[idx] < 256) {
					CharSize = 1;
				}
				else {
					CharSize = 2;
				}
				
				if (StrByteSize + CharSize > StrLen) {
					PaddingStr = SourceStr.substring(0, idx);
					break;
				}
				else {
					StrByteSize += CharSize;
				}
			}
			
			PadCnt = StrLen - StrByteSize;
		}
		
		for (int idx = 0; idx < PadCnt; idx++) {
			PaddingStr = PadChar + PaddingStr;
		}

		return PaddingStr;
	}
	
	public static String LPAD(int SourceStr, int StrLen, char PadChar)
	{
		String result = LPAD(Integer.toString(SourceStr), StrLen, PadChar);
		
		return result;
	}
	
	public static String LPAD(long SourceStr, int StrLen, char PadChar)
	{
		String result = LPAD(Long.toString(SourceStr), StrLen, PadChar);
		
		return result;
	}
	
	
	/**
	 * byte 배열에서 특정 String의 인덱스 Return
	 * @param bytes
	 * @param Char
	 * @return
	 * @throws Exception
	 */
	public static int IndexOf(byte[] bytes, String Char) throws Exception{
		int idx = -1;
		int size = Char.getBytes().length;
		
		String TempStr = "";
		for(int i = 0; i < bytes.length; i++){
			TempStr = new String(bytes, i, size);
			if(TempStr.equals(Char)){
				idx = i;
				break;
			}
		}
		
		return idx;
	}
	
	
	/**
	 * byte 배열에서 Point에서 시작하느 특정 String의 인덱스 Return
	 * @param bytes
	 * @param Point
	 * @param Char
	 * @return
	 * @throws Exception
	 */
	public static int IndexOf(byte[] bytes, int Point, String Char) throws Exception{
		int idx = -1;
		int size = Char.getBytes().length;
		
		String TempStr = "";
		for(int i = Point; i < bytes.length; i++){
			TempStr = new String(bytes, i, size);
			if(TempStr.equals(Char)){
				idx = i;
				break;
			}
		}
		
		return idx;
	}

	/**
	 * 객체의 Class Type을 대문자로 Return 
	 * @param obj
	 * @return
	 * @throws Exception
	 */
	public static String getClassName(Object obj) throws Exception{
		String Type = obj.getClass().getName();
		
		Type = Type.substring(Type.lastIndexOf(".") + 1).toUpperCase();
		
		return Type;
	}
	
	
	/**
	 * @param Str
	 * @return
	 * @throws Exception
	 */
	public static int StringToInt(String Str) throws Exception{
		int result;
		
		try{
			result = Integer.parseInt(Str);
		}catch(Exception e){
			//throw new C2SException("Can not convert to Int. String : " + Str);
			result = 0;
		}
		
		return result;
	}
	
	
	/**
	 * @param Str
	 * @return
	 * @throws Exception
	 */
	public static long StringToLong(String Str) throws Exception{
		long result;
		
		try{
			result = Long.parseLong(Str);
		}catch(Exception e){
			//throw new C2SException("Can not convert to Int. String : " + Str);
			result = 0;
		}
		
		return result;
	}
	

	/**
	 * @param srcStr
	 * @param regex
	 * @return
	 */
	public static String[] Split(String srcStr, String regex){
		if(srcStr == null){
			return null;
		}
		
		if(regex == null || regex.length() == 0){
			String[] returnStr = new String[1];
			returnStr[0] = srcStr;
			return returnStr;
		}
		
		int SplitSize = 0;
		String TempStr = srcStr;
		String Temp = "";
		int point = 0;
		
		while(TempStr.length() > 0){
			point = TempStr.indexOf(regex);
			if(point >= 0){
				Temp = TempStr.substring(0, point);
				TempStr = TempStr.substring(point + regex.length());
			}
			else{
				Temp = TempStr;
				TempStr = "";
			}
			
			if(Temp.length() > 0){
				SplitSize++;
			}
		}
		
		String[] returnStr = new String[SplitSize];
		SplitSize = 0;
		
		TempStr = srcStr;
		while(TempStr.length() > 0){
			point = TempStr.indexOf(regex);
			if(point >= 0){
				Temp = TempStr.substring(0, point);
				TempStr = TempStr.substring(point + regex.length());
			}
			else{
				Temp = TempStr;
				TempStr = "";
			}
			
			if(Temp.length() > 0){
				returnStr[SplitSize] = Temp;
				SplitSize++;
			}
		}
		
		return returnStr;
	}
	
	
	/**
	 * @param srcStr
	 * @param regex
	 * @return
	 */
	public static int[] SplitInt(String srcStr, String regex){
		if(srcStr == null){
			return null;
		}
		
		if(regex == null || regex.length() == 0){
			int[] returnStr = new int[1];
			try{
				returnStr[0] = Utility.StringToInt(srcStr);
			}catch(Exception e){
				returnStr[0] = 0;
			}
			return returnStr;
		}
		
		int SplitSize = 0;
		String TempStr = srcStr;
		String Temp = "";
		int point = 0;
		
		while(TempStr.length() > 0){
			point = TempStr.indexOf(regex);
			if(point >= 0){
				Temp = TempStr.substring(0, point);
				TempStr = TempStr.substring(point + regex.length());
			}
			else{
				Temp = TempStr;
				TempStr = "";
			}
			
			if(Temp.length() > 0){
				SplitSize++;
			}
		}
		
		int[] returnStr = new int[SplitSize];
		SplitSize = 0;
		
		TempStr = srcStr;
		while(TempStr.length() > 0){
			point = TempStr.indexOf(regex);
			if(point >= 0){
				Temp = TempStr.substring(0, point);
				TempStr = TempStr.substring(point + regex.length());
			}
			else{
				Temp = TempStr;
				TempStr = "";
			}
			
			if(Temp.length() > 0){
				try{
					returnStr[SplitSize] = Utility.StringToInt(Temp);
				}catch(Exception e){
					returnStr[SplitSize] = 0;
				}
				SplitSize++;
			}
		}
		
		return returnStr;
	}
	
	/**
	 * @param srcStr
	 * @param regex
	 * @return
	 */
	public static String[] SplitAll(String srcStr, String regex){
		if(srcStr == null){
			return null;
		}
		
		if(regex == null || regex.length() == 0){
			String[] returnStr = new String[1];
			returnStr[0] = srcStr;
			return returnStr;
		}
		
		int SplitSize = 0;
		String TempStr = srcStr;
		String Temp = "";
		int point = 0;
		
		while(TempStr.length() > 0){
			point = TempStr.indexOf(regex);
			if(point >= 0){
				Temp = TempStr.substring(0, point);
				TempStr = TempStr.substring(point + regex.length());
			}
			else{
				Temp = TempStr;
				TempStr = "";
			}
			
			SplitSize++;
		}
		
		String[] returnStr = new String[SplitSize];
		SplitSize = 0;
		
		TempStr = srcStr;
		while(TempStr.length() > 0){
			point = TempStr.indexOf(regex);
			if(point >= 0){
				Temp = TempStr.substring(0, point);
				TempStr = TempStr.substring(point + regex.length());
			}
			else{
				Temp = TempStr;
				TempStr = "";
			}
			
			returnStr[SplitSize] = Temp;
			SplitSize++;
		}
		
		return returnStr;
	}
	
	
	/**
	 * @param srcStr
	 * @param regex
	 * @return
	 */
	public static int[] SplitIntAll(String srcStr, String regex){
		if(srcStr == null){
			return null;
		}
		
		if(regex == null || regex.length() == 0){
			int[] returnStr = new int[1];
			try{
				returnStr[0] = Utility.StringToInt(srcStr);
			}catch(Exception e){
				returnStr[0] = 0;
			}
			return returnStr;
		}
		
		int SplitSize = 0;
		String TempStr = srcStr;
		String Temp = "";
		int point = 0;
		
		while(TempStr.length() > 0){
			point = TempStr.indexOf(regex);
			if(point >= 0){
				Temp = TempStr.substring(0, point);
				TempStr = TempStr.substring(point + regex.length());
			}
			else{
				Temp = TempStr;
				TempStr = "";
			}
			
			SplitSize++;
		}
		
		int[] returnStr = new int[SplitSize];
		SplitSize = 0;
		
		TempStr = srcStr;
		while(TempStr.length() > 0){
			point = TempStr.indexOf(regex);
			if(point >= 0){
				Temp = TempStr.substring(0, point);
				TempStr = TempStr.substring(point + regex.length());
			}
			else{
				Temp = TempStr;
				TempStr = "";
			}
			
			try{
				returnStr[SplitSize] = Utility.StringToInt(Temp);
			}catch(Exception e){
				returnStr[SplitSize] = 0;
			}
			SplitSize++;
		}
		
		return returnStr;
	}
	
	/**
	 * StringBuffer replaceAll
	 * @param SrcBuff
	 * @param RegexStr
	 * @param ReplaceStr
	 * @return
	 */
	public static StringBuffer StringBufferReplaceAll(StringBuffer SrcBuff, String RegexStr, String ReplaceStr){
		int idx = -1;
		
		while((idx = SrcBuff.indexOf(RegexStr)) >= 0){
			SrcBuff = SrcBuff.replace(idx, idx + RegexStr.length(), ReplaceStr);
		}
		
		return SrcBuff;
	}
	
	
	public static String MarkDate(String DateStr){
		String Result = "";
		
		if(DateStr.length() == 6){
			Result = DateStr.substring(0, 2) + "년 " + DateStr.substring(2, 4) + "월 " + DateStr.substring(4) + "일";
		}
		else if(DateStr.length() == 8){
			Result = DateStr.substring(0, 4) + "년 " + DateStr.substring(4, 6) + "월 " + DateStr.substring(6) + "일";
		}
		else{
			Result = DateStr;
		}
		
		return Result;
	}
	
	
	public static String MarkDate(String DateStr, String Mark){
		String Result = "";
		
		if(DateStr.length() == 6){
			Result = DateStr.substring(0, 2) + Mark + DateStr.substring(2, 4) + Mark + DateStr.substring(4);
		}
		else if(DateStr.length() == 8){
			Result = DateStr.substring(0, 4) + Mark + DateStr.substring(4, 6) + Mark + DateStr.substring(6);
		}
		else{
			Result = DateStr;
		}
		
		return Result;
	}

	public static String MarkTime(String TimeStr, String Mark){
		String Result = "";
		
		if(TimeStr.length() == 4){
			Result = TimeStr.substring(0, 2) + Mark + TimeStr.substring(2);
		}
		else if(TimeStr.length() == 6){
			Result = TimeStr.substring(0, 2) + Mark + TimeStr.substring(2, 4) + Mark + TimeStr.substring(4);
		}
		else{
			Result = TimeStr;
		}
		
		return Result;
	}
	
	
	public static String setComma(String str){
		if(str == null || str == "") return "";
		
		str = str.trim();
		String BuffStr = str;
		
		String ReturnStr = "";
		
		try{
			String Minus = "";
			if(BuffStr.substring(0, 1).equals("-")){
				Minus = "-";
				BuffStr = BuffStr.substring(1);
			}
	
			int DotPoint = BuffStr.indexOf(".");
			
			String Prefix = "";
			String Suffix = "";
			
			if(DotPoint > 0){
				Prefix = BuffStr.substring(0, DotPoint);
				Suffix = BuffStr.substring(DotPoint + 1);
			}
			else{
				Prefix = BuffStr;
			}
			
			for(int idx = Prefix.length(); idx > 0; idx = idx - 3){
				if(idx - 3 > 0){
					ReturnStr = "," + BuffStr.substring(idx - 3, idx) + ReturnStr;
				}
				else{
					ReturnStr = BuffStr.substring(0, idx) + ReturnStr;
				}
			}
			
			if(DotPoint > 0){
				ReturnStr += "." + Suffix;
			}
			
			ReturnStr = Minus + ReturnStr;
		}catch(Exception e){
			ReturnStr = str;
		}
		
		return  ReturnStr;
	}
	
	public static String setComma(int str){
		return  setComma(Integer.toString(str));
	}
	
	public static String setComma(long str){
		return  setComma(Long.toString(str));
	}
	
	
	/**
	 * Xml 파일 읽는다.
	 * Document를 반환한다.
	 * 
	 * @param is
	 * @return
	 * @throws Exception
	 */
	public static Document loadXml(InputStream is) throws Exception{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		factory.setIgnoringElementContentWhitespace(true);
		DocumentBuilder builder = factory.newDocumentBuilder();
		
		Document doc = builder.parse(is);
		
		return doc;
	}
	
	
	/**
	 * Xml 파일 읽는다.
	 * Document를 반환한다.
	 * 
	 * @param rd
	 * @return
	 * @throws Exception
	 */
	public static Document loadXml(Reader rd) throws Exception{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		factory.setIgnoringElementContentWhitespace(true);
		DocumentBuilder builder = factory.newDocumentBuilder();
		
		InputSource iu = new InputSource(new BufferedReader(rd));
		
		Document doc = builder.parse(iu);
		
		return doc;
	}
	
	
	/**
	 * Xml 파일 읽는다.
	 * Document를 반환한다.
	 * 
	 * @param FileName
	 * @return
	 * @throws Exception
	 */
	public static Document loadXml(String FileName) throws Exception{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		factory.setIgnoringElementContentWhitespace(true);
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document doc = builder.parse(FileName);
		
		return doc;
	}
	
	
	/**
	 * xml 파일 읽는다.
	 * Document를 반환한다.
	 * 
	 * @param fileName
	 * @return
	 * @throws Exception
	 */
	public static Document loadXmlFile(String FileName) throws Exception{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		factory.setIgnoringElementContentWhitespace(true);
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document doc = builder.parse(Utility.class.getResourceAsStream(FileName));
		
		return doc;
	}
	
	
	/**
	 * Xml String 읽는다.
	 * Document를 반환한다.
	 * 
	 * @param XmlData
	 * @return
	 * @throws Exception
	 */
	public static Document loadXmlString(String XmlData) throws Exception{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		factory.setIgnoringElementContentWhitespace(true);
		DocumentBuilder builder = factory.newDocumentBuilder();
		
		InputSource iu = new InputSource(new StringReader(XmlData));
		
		Document doc = builder.parse(iu);
		
		return doc;
	}
	
	public static String ReplaceAll(String str, String src, String tgt){
		StringBuffer buf = new StringBuffer();
		String ch  = null;

		if(str == null || str.length() == 0){
			return "";
		}

		int idx = 0;
		int len = src.length();
		while(idx < str.length() - len + 1){
			ch = str.substring(idx, idx + len);
			if(ch.equals(src)){
				buf.append(tgt);
				idx = idx + len;
			}
			else{
				buf.append(str.substring(idx, idx + 1));
				idx++;
			}
		}

		if(idx < str.length()){
			buf.append(str.substring(idx, str.length()));
		}

		return buf.toString();
	}
	
	
	public static String ReplaceAll(String str, String src, int tgt){
		StringBuffer buf = new StringBuffer();
		String ch  = null;

		if(str == null || str.length() == 0){
			return "";
		}

		int idx = 0;
		int len = src.length();
		while(idx < str.length() - len + 1){
			ch = str.substring(idx, idx + len);
			if(ch.equals(src)){
				buf.append(tgt);
				idx = idx + len;
			}
			else{
				buf.append(str.substring(idx, idx + 1));
				idx++;
			}
		}

		if(idx < str.length()){
			buf.append(str.substring(idx, str.length()));
		}

		return buf.toString();
	}
	
	
	public static String ReplaceAll(String str, String src, long tgt){
		StringBuffer buf = new StringBuffer();
		String ch  = null;

		if(str == null || str.length() == 0){
			return "";
		}

		int idx = 0;
		int len = src.length();
		while(idx < str.length() - len + 1){
			ch = str.substring(idx, idx + len);
			if(ch.equals(src)){
				buf.append(tgt);
				idx = idx + len;
			}
			else{
				buf.append(str.substring(idx, idx + 1));
				idx++;
			}
		}

		if(idx < str.length()){
			buf.append(str.substring(idx, str.length()));
		}

		return buf.toString();
	}
	
	public static String getRandomString(){
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}
