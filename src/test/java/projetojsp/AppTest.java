package projetojsp;

import static org.junit.Assert.assertTrue;

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
    public void shouldAnswerWithTrue()
    {
    	double total = 24;
    	
    	double paginas = total / 10;
    	
    	if((total % 10) > 0 ) {
    		paginas += 1;
    	}
    	
    	System.out.println((int) paginas);
    }
}
