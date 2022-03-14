package util;

import java.io.File;
import java.io.Serializable;
import java.util.HashMap;
import java.util.List;

import jakarta.servlet.ServletContext;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@SuppressWarnings({ "rawtypes", "unchecked" })
public class ReportUtil implements Serializable {

	private static final long serialVersionUID = 1L;

	public byte[] geraRelatorioPDF(List listaDados, String nomeRelatorio, ServletContext context) throws Exception {

		/* Cria a lista de dados que vem da consulta SQL */
		JRBeanCollectionDataSource data = new JRBeanCollectionDataSource(listaDados);

		String caminhoJasper = context.getRealPath("relatorios") + File.separator + nomeRelatorio + ".jasper";

		JasperPrint printer = JasperFillManager.fillReport(caminhoJasper, new HashMap(), data);

		return JasperExportManager.exportReportToPdf(printer);

	}

	public byte[] geraRelatorioPDF(List listDados, HashMap<String, Object> params, String nomeRelatorio, ServletContext context) throws Exception {

		/* Cria a lista de dados que vem da consulta SQL */
		JRBeanCollectionDataSource data = new JRBeanCollectionDataSource(listDados);
		
		String caminhoJasper = context.getRealPath("relatorios") + File.separator + nomeRelatorio + ".jasper";

		JasperPrint printer = JasperFillManager.fillReport(caminhoJasper, params, data);

		return JasperExportManager.exportReportToPdf(printer);

	}
}
