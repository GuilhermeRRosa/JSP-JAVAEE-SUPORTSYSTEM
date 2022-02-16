package util;

import java.io.File;
import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@SuppressWarnings({"rawtypes", "unchecked"})
public class ReportUtil implements Serializable{

	private static final long serialVersionUID = 1L;
	
	public byte[] geraRelatorioPDF(List listaDados, String nomeRelatorio, ServletContext context) throws Exception{
		
		/*Cria a lista de dados que vem da consulta SQL*/
		JRBeanCollectionDataSource data = new JRBeanCollectionDataSource(listaDados);
		
		String caminhoJasper = context.getRealPath("relatorios") + File.separator + nomeRelatorio + ".jasper";
		
		JasperPrint printer = JasperFillManager.fillReport(caminhoJasper, new HashMap(), data);
		
		return JasperExportManager.exportReportToPdf(printer);
		
	}
	
	public byte[] geraRelatorioPDF(Object obj, String nomeRelatorio, ServletContext context) throws Exception{
		
		/*Cria a lista de dados que vem da consulta SQL*/
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("obj", obj);
		
		String caminhoJasper = context.getRealPath("relatorios") + File.separator + nomeRelatorio + ".jasper";
		
		JasperPrint printer = JasperFillManager.fillReport(caminhoJasper, params, new JREmptyDataSource());
		
		return JasperExportManager.exportReportToPdf(printer);
		
	}

}
