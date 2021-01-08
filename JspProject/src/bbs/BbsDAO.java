package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;
	private ResultSet rs;

	public BbsDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "BBS";
			String dbPassword = "12345";

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getDate() {
		String SQL = "SELECT SYSDATE FROM DUAL";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS (bbsID,bbsTitle,userID,bbsContent,bbsAvaliable)" + "VALUES (?, ?, ?, ?, ?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, bbsContent);
			pstmt.setInt(5, 1);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류

	}

	public ArrayList<Bbs> getList(int pageNumber) {

		String SQL = "SELECT bbsID, bbstitle, userid, bbsdate, bbscontent, bbsavaliable, PAGECOUNT "
				+ "FROM ( SELECT bbsID, bbstitle, userid, bbsdate, bbscontent, bbsavaliable, ROWNUM PAGECOUNT "
				+ "FROM BBS WHERE bbsID > 0 AND bbsAvaliable = 1 AND ROWNUM <= ? )WHERE PAGECOUNT > ? ORDER BY BBSID DESC";
		// 페이지 개설을 위해 만든 SQL문장이다. 위에서 10개까지만의 행을 가져오는 질의문으로서 LIMIT 절을 MySQL에서는 사용 가능한데
		// 오라클의 ROWNUM 같은 경우는 쿼리가 완전히 수행되지 않은 원 데이터의 정렬 순서대로 번호를 매기기 때문에 전혀 다른 결과가 나와서
		// SELET 문으로 한번더 감싸 준 것이다.
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pageNumber * 10);
			pstmt.setInt(2, pageNumber * 10 - 10);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvaliable(rs.getInt(6));

				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;

	}

	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1,bbsID);
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Bbs bbs = new Bbs();
				
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvaliable(rs.getInt(6));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	
	public int delete(int bbsID) {
		
		String SQL = "UPDATE BBS SET bbsAvaliable = 0 WHERE bbsID =  ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
		
	}

	/*
	 * public boolean nextPage (int pageNumber) { String SQL =
	 * "SELECT * FROM BBS WHERE bbsID <= ? AND bbsAvaliable = 1";
	 * 
	 * try { PreparedStatement pstmt = conn.prepareStatement(SQL); pstmt.setInt(1,
	 * getNext() - (pageNumber - 1 * 10)); rs = pstmt.executeQuery(); if (
	 * rs.next()) { return true; } }catch (Exception e) { e.printStackTrace(); }
	 * return false; }
	 */

}
