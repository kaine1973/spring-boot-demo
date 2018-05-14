package rk.util;

import io.netty.util.internal.MathUtil;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public final class StringUtil {


	public static Boolean isNullorEmpty(String... str) {
		for (String s : str) {
			if (null == s) {
				return true;
			} else {
				if ("".equals(s.trim())) {
					return true;
				}
			}
		}
		return false;
	}
	public static String firstChar2Upper(String str){
		return str.toUpperCase().charAt(0)+str.substring(1);
	}
	/**
	 * md5加密
	 * @param str
	 * @return
	 */
	public static String encypt(String str) {
		String s = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] digest = md.digest(str.getBytes());
			s = bytesToHex(digest);

		} catch (NoSuchAlgorithmException e) {
			System.out.println("加密字符异常"+e.getMessage()+e.getStackTrace());
		}
		return s;
	}

	public static String bytesToHex(byte[] bytes) {
		StringBuffer hexStr = new StringBuffer();
		int num;
		for (int i = 0; i < bytes.length; i++) {
			num = bytes[i];
			if(num < 0) {
				num += 256;
			}
			if(num < 16){
				hexStr.append("0");
			}
			hexStr.append(Integer.toHexString(num));
		}
		return hexStr.toString().toUpperCase();
	}

	public static String genNewFileName(){
		String s = "";
		String common = "abcdefghijklmnopqrstuvwxyz01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		for(int i = 0;i < 10;i++){
			s += common.charAt((int)(Math.random()*63));
		}
		return s;
	}

	public static void main(String[] args) {
		System.out.println(genNewFileName());
	}

}
