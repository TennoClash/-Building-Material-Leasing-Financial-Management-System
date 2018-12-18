package bmlfms.entity;

import java.io.Serializable;

public class KeyU implements Serializable{
/**
	 * 
	 */
	private static final long serialVersionUID = -5445114851292158796L;
private String Modulus;
private String Exponent;
public String getModulus() {
	return Modulus;
}
public void setModulus(String modulus) {
	Modulus = modulus;
}
public String getExponent() {
	return Exponent;
}
public void setExponent(String exponent) {
	Exponent = exponent;
}

}
