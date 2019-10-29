package gui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTable;
import javax.swing.JTextField;

@SuppressWarnings("serial")
public class Reservar extends JPanel{
	
	private static Reservar instance = null;
	static JTable tabla;
	static JTable tablaMostrar;
	static Connection conn;
	static String legajo;

	public static Reservar getInstance(JTable t, JTable tm, Connection c, String l,boolean iv) {
		tabla=t;
		tablaMostrar=tm;
		conn=c;
		legajo=l;
		if (instance == null) {
			instance = new Reservar();
		}
		if(iv) {
			function();
		}
		return instance;
	}

	private Reservar() {
		this.setName("Reservar un vuelo");
		this.setLayout(null);
		this.setBounds(250,50,600,300);
		this.setVisible(true);
		
		//Labels
		JLabel vueloIda= new JLabel("Vuelo de ida:");
		JLabel claseIda= new JLabel("Clase de ida:");
		JLabel tipoD= new JLabel("Tipo de documento:");
		JLabel numD= new JLabel("Numero de documento:");
		JLabel emp= new JLabel("Empleado:");

		vueloIda.setBounds(5, 0, 150, 25);
		claseIda.setBounds(5, 30, 150, 25);
		tipoD.setBounds(5, 60, 150, 25);
		numD.setBounds(5, 90, 150, 25);
		emp.setBounds(5, 120, 150, 25);

		this.add(vueloIda);
		this.add(claseIda);
		this.add(tipoD);
		this.add(numD);
		this.add(emp);
		
		//TextField
		JTextField vi= new JTextField();
		JTextField ci= new JTextField();
		JTextField td= new JTextField();
		JTextField nd= new JTextField();
		JTextField e= new JTextField();

		vi.setBounds(150, 0, 150, 25);
		ci.setBounds(150, 30, 150, 25);
		td.setBounds(150, 60, 150, 25);
		nd.setBounds(150, 90, 150, 25);
		e.setBounds(150, 120, 150, 25);
		
		vi.setEditable(false);
		ci.setEditable(false);
		e.setEditable(false);

		vi.setText(tabla.getValueAt(tabla.getSelectedRow(), 0).toString());
		ci.setText(tablaMostrar.getValueAt(tablaMostrar.getSelectedRow(), 1).toString());
		e.setText(legajo);

		this.add(vi);
		this.add(ci);
		this.add(td);
		this.add(nd);
		this.add(e);
		
		//Botones de finalizacion
		JButton reservar= new JButton("Reservar");
		reservar.setBounds(200, 250, 100, 50);
		reservar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				//Llamar a SQL con conn y hacerle				
			}
		});
		this.add(reservar);
	}

	private static void function() {
		JLabel vueloVuelta= new JLabel("Vuelo de vuelta:");
		JLabel claseVuelta= new JLabel("Clase de vuelta:");
		JTextField vv= new JTextField();
		JTextField cv= new JTextField();

		vueloVuelta.setBounds(0, 150, 110, 25);
		claseVuelta.setBounds(0, 180, 110, 25);			
		vv.setBounds(150, 150 , 150, 25);
		cv.setBounds(150, 180 , 150, 25);
		vv.setText(tabla.getValueAt(tabla.getSelectedRow(), 0).toString());
		cv.setText(tablaMostrar.getValueAt(tablaMostrar.getSelectedRow(), 1).toString());
		vv.setEditable(false);
		cv.setEditable(false);

		instance.add(vueloVuelta);
		instance.add(claseVuelta);
		instance.add(vv);
		instance.add(cv);
	}
}
	

