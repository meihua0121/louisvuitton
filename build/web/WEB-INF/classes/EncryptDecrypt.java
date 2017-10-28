/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author Makhtar Ba
 */
public class EncryptDecrypt {
    private static final String SECRET_KEY_1 = "g5f121236fvg12gf";
    private static final String SECRET_KEY_2 = "Art542BnhjlC5ftB";
    private IvParameterSpec ivParameterSpec;
    private SecretKeySpec secretKeySpec;
    private Cipher cipher;
 
    public EncryptDecrypt() throws UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException {
        this.ivParameterSpec = new IvParameterSpec(SECRET_KEY_1.getBytes("UTF-8"));
        this.secretKeySpec = new SecretKeySpec(SECRET_KEY_2.getBytes("UTF-8"), "AES");
        cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
    }
    public IvParameterSpec getIvParameterSpec() {
        return  ivParameterSpec;
    }

    public void setIvParameterSpec(IvParameterSpec IvParameterSpec) {
        this.ivParameterSpec = IvParameterSpec;
    }
    public SecretKeySpec getSecretKeySpec() {
        return  secretKeySpec;
    }

    public void setSecretKeySpec(SecretKeySpec SecretKeySpec) {
        this.secretKeySpec = SecretKeySpec;
    }
    public Cipher getCipher() {
        return  cipher;
    }

    public void setCipher(Cipher Cipher) {
        this.cipher = Cipher;
    }
}
