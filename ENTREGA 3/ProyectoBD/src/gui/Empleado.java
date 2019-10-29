package gui;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import fecha.Fechas;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JFormattedTextField;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.JSeparator;
import javax.swing.JTable;
import javax.swing.SwingConstants;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableModel;
import javax.swing.text.MaskFormatter;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;

public class Empleado extends JFrame{
	/**
	 * Autogenerated serialVersionUID for JFrame
	 */
	private static final long serialVersionUID = -2735425409835907346L;
	private String legajo;

	private static Connection conn = null;
	private JFormattedTextField fechaSalida, fechaVuelta; 
	private JTextField CO2, CD2;
	private MaskFormatter mask;

	/**
	 * Create the application.
	 */
	public Empleado(Connection c, String leg) {
		legajo = leg;
		conn = c;
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		this.setBounds(250, 150, 550, 500);
		this.setResizable(false);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		getContentPane().setLayout(null);
		getContentPane().setBounds(0, 0, 500, 500);
		
		inicializarPanelCiudades();
		
		JSeparator separator = new JSeparator();
		separator.setBounds(0, 101, 984, 2);
		getContentPane().add(separator);
		
		JSeparator separator_1 = new JSeparator();
		separator_1.setOrientation(SwingConstants.VERTICAL);
		separator_1.setBounds(110, 0, 2, 103);
		getContentPane().add(separator_1);
		
		JSeparator separator_2 = new JSeparator();
		separator_2.setOrientation(SwingConstants.VERTICAL);
		separator_2.setBounds(297, 0, 2, 103);
		getContentPane().add(separator_2);
		
		inicializarPanelVuelos();
	}
	
	private void inicializarPanelCiudades() {
		//Ciudad de Origen y Destino
		JLabel CO= new JLabel("Ciudad Origen:");
		CO2= new JTextField();
		CO2.setToolTipText("");
		JLabel CD= new JLabel("Ciudad Destino:");
		CD2= new JTextField();
		
		CO.setBounds(0, 0, 100, 20);
		CD.setBounds(0, 50, 100, 20);
		
		CO2.setBounds(0, 20, 100, 20);
		CO2.setVisible(true);
		CO2.setEditable(true);
		CO2.setFocusable(true);
		
		CD2.setBounds(0, 70 , 100, 20);
		CD2.setVisible(true);
		CD2.setEditable(true);
		CD2.setFocusable(true);

		getContentPane().add(CO);
		getContentPane().add(CD);
		getContentPane().add(CO2);
		getContentPane().add(CD2);		
	}
	
	private void inicializarPanelVuelos() {
		JLabel lblFechaDeseadaPara = new JLabel("Fecha vuelo ida");
		lblFechaDeseadaPara.setBounds(309, 3, 180, 14);
		getContentPane().add(lblFechaDeseadaPara);
		
		JLabel lblSeleccioneUnaOpcin = new JLabel("Seleccione una opci\u00F3n:");
		lblSeleccioneUnaOpcin.setBounds(122, 3, 165, 14);
		getContentPane().add(lblSeleccioneUnaOpcin);
		
		JLabel lblFechaVueloDe = new JLabel("Fecha vuelo vuelta");
		lblFechaVueloDe.setBounds(309, 53, 180, 14);
		getContentPane().add(lblFechaVueloDe);
		
		try{
			 mask = new MaskFormatter("##/##/####");
		}
		catch(ParseException ex){}
		
		fechaSalida = new JFormattedTextField(mask);
		fechaSalida.setToolTipText("");
		fechaSalida.setBounds(309, 25, 100, 20);
		getContentPane().add(fechaSalida);
		fechaSalida.setColumns(10);
		fechaSalida.setVisible(false);
		fechaSalida.setEditable(false);
		fechaSalida.setFocusable(false);
		
		fechaVuelta = new JFormattedTextField(mask);
		fechaVuelta.setToolTipText("");
		fechaVuelta.setColumns(10);
		fechaVuelta.setBounds(309, 70, 100, 20);
		getContentPane().add(fechaVuelta);
		fechaVuelta.setVisible(false);
		fechaVuelta.setEditable(false);
		fechaVuelta.setFocusable(false);
		
		inicializarBotones();
	}

	private void inicializarBotones() {
		JRadioButton idaVuelta = new JRadioButton("Vuelos de ida y vuelta");
		idaVuelta.setBounds(118, 49, 173, 23);
		getContentPane().add(idaVuelta);
		idaVuelta.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				fechaVuelta.setVisible(true);
				fechaVuelta.setEditable(true);
				fechaVuelta.setFocusable(true);
				fechaSalida.setVisible(true);
				fechaSalida.setEditable(true);
				fechaSalida.setFocusable(true);
			}
		});
		
		JRadioButton ida = new JRadioButton("Vuelos de ida");
		ida.setBounds(118, 24, 173, 23);
		getContentPane().add(ida);
		ida.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				fechaVuelta.setVisible(false);
				fechaVuelta.setEditable(false);
				fechaVuelta.setFocusable(false);
				fechaSalida.setVisible(true);
				fechaSalida.setEditable(true);
				fechaSalida.setFocusable(true);
			}
		});
		
		ButtonGroup bg = new ButtonGroup();
		bg.add(idaVuelta);
		bg.add(ida);	
		
		
		JButton consultar = new JButton("Consultar");
		consultar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if((CO2.getText() == null) || (CD2.getText() == null) || fechaSalida.getText() == null)
					JOptionPane.showMessageDialog(null, "Debe completar todos los campos antes de realizar una consulta.", "ERROR: Complete todos los campos", JOptionPane.ERROR_MESSAGE);
				else
					if(idaVuelta.isSelected() && fechaVuelta.getText() == null)
						JOptionPane.showMessageDialog(null, "Debe completar todos los campos antes de realizar una consulta.", "ERROR: Complete todos los campos", JOptionPane.ERROR_MESSAGE);
					else {
						try {
							Toolkit tk = getToolkit();
							Dimension d = tk.getScreenSize();
							Statement stmt = conn.createStatement();
							String origen = CO2.getText();
							String destino = CD2.getText();
							Date fechaS = Fechas.convertirStringADateSQL(fechaSalida.getText());
							String sqlIDA = "SELECT DISTINCT vuelo, modelo_avion, aeropuerto_salida, aeropuerto_llegada, hora_sale, hora_llega, tiempo_estimado "
										+ "FROM vuelos_disponibles "
										+ "WHERE (ciudad_salida = '" + origen + "') AND (ciudad_llegada = '" + destino + "') AND (fecha = '" + fechaS + "')";
							ResultSet rs = stmt.executeQuery(sqlIDA);
							ResultSetMetaData rsmd = rs.getMetaData();
							int cantColumn = rsmd.getColumnCount();
							String[] column_name = new String[cantColumn];
							Class<?>[] column_class = new Class[cantColumn];							
							DefaultTableModel model = buildModel(column_name, column_class, cantColumn, rsmd);
							JTable tablaIda = buildTable(model, rs, cantColumn, column_name);
							tablaIda.getSelectionModel().addListSelectionListener(new ListSelectionListener(){
								public void valueChanged(ListSelectionEvent e){
									String instancia= tablaIda.getValueAt(tablaIda.getSelectedRow(), 0).toString();
									String reservas= "SELECT vuelo, clase, precio, cant_asientos FROM vuelos_disponibles WHERE vuelo = '" + instancia +"' AND vuelos_disponibles.fecha = '" + fechaS + "'";
									try{
										Statement stmt2 = conn.createStatement();
										ResultSet rs2 = stmt2.executeQuery(reservas);
										ResultSetMetaData md2= rs2.getMetaData();
										int columnas= md2.getColumnCount();
										String[] column_name2 = new String[columnas];
										Class<?>[] column_class2 = new Class[columnas];
										DefaultTableModel tablaReservas = buildModel(column_name2, column_class2, columnas, md2);
										JTable tablaMostrar= new JTable(tablaReservas){
											private static final long serialVersionUID= 1L;
											
											public Component prepareRenderer (TableCellRenderer renderer, int fila, int columna){
												Component toReturn= super.prepareRenderer(renderer, fila, columna);
												return toReturn;
											}
										};
										tablaMostrar.getSelectionModel().addListSelectionListener(new ListSelectionListener() {
											
											public void valueChanged(ListSelectionEvent arg0) {
												Reservar res= Reservar.getInstance(tablaIda, tablaMostrar, conn, legajo, false);
												tablaMostrar.getParent().add(res);
											}
										});
										Object[] labels= new Object[columnas];
										for(int i= 0; i < columnas; i++){
											labels[i]= md2.getColumnLabel(i+1);
										}
										tablaReservas.setColumnIdentifiers(labels);
										
										while(rs2.next()){
											Object [] fila = new Object[columnas];
											for(int i=0; i < columnas; i++){
												fila[i]= rs2.getObject(i+1);
											}
											tablaReservas.addRow(fila);
										}
										JOptionPane.showMessageDialog(null, new JScrollPane(tablaMostrar), "Reservas", JOptionPane.PLAIN_MESSAGE);
									}
									catch(SQLException e15){
										JOptionPane.showMessageDialog(null,e15.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
										
									}
								}
							});
							// se cierran los recursos utilizados 
							rs.close();
							stmt.close(); 
							if (idaVuelta.isSelected()) {
								Date fechaV = Fechas.convertirStringADateSQL(fechaVuelta.getText());
								Statement stm = conn.createStatement();
								String sqlVuelta = "SELECT DISTINCT vuelo, modelo_avion, aeropuerto_salida, aeropuerto_llegada, hora_sale, hora_llega, tiempo_estimado "
										+ "FROM vuelos_disponibles "
										+ "WHERE (ciudad_salida = '" + destino + "') AND (ciudad_llegada = '" + origen + "') AND (fecha = '" + fechaV + "')";
								ResultSet res = stm.executeQuery(sqlVuelta);
								JTable tablaVuelta = buildTable(model, res, cantColumn, column_name);   
								res.close();
								stm.close();
								tablaVuelta.getSelectionModel().addListSelectionListener(new ListSelectionListener(){
									public void valueChanged(ListSelectionEvent e){
										String instancia= tablaVuelta.getValueAt(tablaVuelta.getSelectedRow(), 0).toString();
										String reservas= "SELECT vuelo, clase, precio, cant_asientos FROM vuelos_disponibles WHERE vuelo = '" + instancia  +"' AND vuelos_disponibles.fecha = '" + fechaV + "'";
										try{
											Statement stmt2 = conn.createStatement();
											ResultSet rs2 = stmt2.executeQuery(reservas);
											ResultSetMetaData md2= rs2.getMetaData();
											int columnas= md2.getColumnCount();
											String[] column_name2 = new String[columnas];
											Class<?>[] column_class2 = new Class[columnas];
											DefaultTableModel tablaReservas = buildModel(column_name2, column_class2, columnas, md2);
											JTable tablaMostrar= new JTable(tablaReservas){
												private static final long serialVersionUID= 1L;
												public Component prepareRenderer (TableCellRenderer renderer, int fila, int columna){
													Component toReturn= super.prepareRenderer(renderer, fila, columna);
													return toReturn;
												}
											};
											tablaMostrar.getSelectionModel().addListSelectionListener(new ListSelectionListener() {
												
												public void valueChanged(ListSelectionEvent arg0) {
													Reservar res = Reservar.getInstance(tablaVuelta, tablaMostrar, conn, legajo, true);
													Component comp = tablaMostrar.getParent().getComponentAt(250, 50);
													if(comp != null)
														tablaMostrar.getParent().remove(comp);
													tablaMostrar.getParent().add(res);
													res.repaint();
													res.revalidate();
												}
											});
											Object[] labels= new Object[columnas];
											for(int i= 0; i < columnas; i++){
												labels[i]= md2.getColumnLabel(i+1);
											}
											tablaReservas.setColumnIdentifiers(labels);
											
											while(rs2.next()){
												Object [] fila = new Object[columnas];
												for(int i=0; i < columnas; i++){
													fila[i]= rs2.getObject(i+1);
												}
												tablaReservas.addRow(fila);
											}
											JOptionPane.showMessageDialog(null, new JScrollPane(tablaMostrar), "Reservas", JOptionPane.PLAIN_MESSAGE);
										}
										catch(SQLException e15){
											JOptionPane.showMessageDialog(null,e15.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
											
										}
									}
								});
								JScrollPane scrTablaVuelta = new JScrollPane(tablaVuelta);
								scrTablaVuelta.setName("Scroll Tabla Vuelta");
								scrTablaVuelta.setBounds(0, ((getContentPane().getHeight()-100)/2)+100, getContentPane().getWidth(), (getContentPane().getHeight()-100)/2);
								Component comp = getContentPane().getComponentAt(0, ((getContentPane().getHeight()-100)/2)+100);
								if(comp != null)
									getContentPane().remove(comp);
								getContentPane().add(scrTablaVuelta);
							}						
							JScrollPane scrTablaIda = new JScrollPane(tablaIda);
							scrTablaIda.setName("Scroll Tabla Ida");
							scrTablaIda.setBounds(0, 100, getContentPane().getWidth(), (getContentPane().getHeight()-100)/2);
							Component comp = getContentPane().getComponentAt(0, 100); 
							if(comp != null)
								getContentPane().remove(comp);
							getContentPane().add(scrTablaIda);
							Component comp2 = getContentPane().getComponentAt(0, ((getContentPane().getHeight()-100)/2)+100);
							if(comp2 != null && !idaVuelta.isSelected())
								getContentPane().remove(comp2);
							getContentPane().repaint();
							getContentPane().revalidate();
						}
						catch(SQLException ex) {
							JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR: SQL Error", JOptionPane.ERROR_MESSAGE);
						}
					}
			}
		});
		consultar.setBounds(435, 20, 100, 20);
		getContentPane().add(consultar);
		
		JSeparator separator_3 = new JSeparator();
		separator_3.setOrientation(SwingConstants.VERTICAL);
		separator_3.setBounds(430, 0, 2, 103);
		getContentPane().add(separator_3);
	}
	
	private TablaVuelosModel buildModel(String[] column_name, Class<?>[] column_class, int cantColum, ResultSetMetaData rsmd) {
		try {
		    for (int i = 0; i < cantColum; i++) {
		    	column_name[i] = rsmd.getColumnName(i+1);
		    	try {
		    		column_class[i] = Class.forName(rsmd.getColumnClassName(i+1));
		    	}
		    	catch(ClassNotFoundException ex) {
		    		JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR: Eror en SQL", JOptionPane.ERROR_MESSAGE);
		    	}
		    }
		    return new TablaVuelosModel(column_class , column_name);
		}
		catch(SQLException ex) {
			JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR: Error en SQL", JOptionPane.ERROR_MESSAGE);
			return null;
		}
	}
	
	private JTable buildTable(TableModel model, ResultSet rs, int cantColumn, String[] column_name) {
		try {
			//Tabla
			JTable tabla = new JTable(); // Crea una tabla
			tabla.setModel(model); // setea el modelo de la tabla  
			tabla.setAutoCreateRowSorter(true); // activa el ordenamiento por columnas, para
			tabla.setDefaultRenderer(java.sql.Time.class, new SqlTimeRenderer());
			
			int i = 0;
			while (rs.next())
			{
				((DefaultTableModel) tabla.getModel()).setRowCount(i + 1);
				// se agregan a la tabla los datos correspondientes cada celda de la fila recuperada
				for(int j = 0; j < cantColumn; j++) {
					tabla.setValueAt(rs.getObject(column_name[j]), i, j);
				}
				i++;
			}      
			return tabla;
		} 
		catch (SQLException e1) {
			JOptionPane.showMessageDialog(null, e1.getMessage(), "ERROR: Error en SQL", JOptionPane.ERROR_MESSAGE);
			return null;
		}	
	}
	
	public final class SqlTimeRenderer extends DefaultTableCellRenderer {
		
		/**
		 * 
		 */
		private static final long serialVersionUID = 3711032294462400327L;
		
		private final DateFormat timeFormatter = new SimpleDateFormat("HH:mm:ss");
		
		public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
			//aca habia un instace of de value en java.sql.Time
			value = timeFormatter.format(value);
			return super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column); 
		}
		
	}	
	
	final class TablaVuelosModel extends DefaultTableModel{
		private static final long serialVersionUID = 5346108049766426615L;
		// define la clase java asociada a cada columna de la tabla
		private Class<?>[] types;
		// define si una columna es editable
		private boolean[] canEdit;
		TablaVuelosModel(Class<?>[] classes, String[] names){
			super(new String[][] {}, names);
			types = classes;
			canEdit= new boolean[names.length];
			for (int i = 0; i < canEdit.length; i++)
				canEdit[i] = false;
		};             	
		
		// recupera la clase java de cada columna de la tabla
		public Class<?> getColumnClass(int columnIndex) 
		{
			return types[columnIndex];
		}
		// determina si una celda es editable
		public boolean isCellEditable(int rowIndex, int columnIndex) 
		{
			return canEdit[columnIndex];
		}         	          	            	
	}
}
