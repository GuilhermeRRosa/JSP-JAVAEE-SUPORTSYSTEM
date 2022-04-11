package projetojsp;

import java.sql.Timestamp;

import org.junit.Test;

/**
 * Unit test for simple App.
 */
public class AppTest 
{
    /**
     * Rigorous Test :-)
     */
	
	@Test
	public static void main(String[] args) {
		
		testaData();
	}
    
    @Test
    public static void testaData() {
    	Timestamp dataAgora =  new Timestamp(new java.util.Date().getTime());
    	
    	System.out.println(dataAgora);
    	
    }
}
