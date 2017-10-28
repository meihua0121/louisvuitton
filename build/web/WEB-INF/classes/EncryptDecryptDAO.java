/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;
import org.apache.commons.codec.binary.Base64;

/**
 *
 * @author HP
 */

 
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import entity.EncryptDecrypt;


public class EncryptDecryptDAO {
 


    public String encrypt(EncryptDecrypt encrypt, String toBeEncrypt) throws InvalidKeyException, IllegalBlockSizeException, BadPaddingException, InvalidAlgorithmParameterException {
        encrypt.getCipher().init(Cipher.ENCRYPT_MODE, encrypt.getSecretKeySpec(), encrypt.getIvParameterSpec());
        byte[] encrypted = encrypt.getCipher().doFinal(toBeEncrypt.getBytes());
        return Base64.encodeBase64String(encrypted);
    }

    public String decrypt(EncryptDecrypt encrypt, String encrypted) throws InvalidAlgorithmParameterException, InvalidKeyException,
            BadPaddingException, IllegalBlockSizeException {
        try{
            encrypt.getCipher().init(Cipher.DECRYPT_MODE, encrypt.getSecretKeySpec(), encrypt.getIvParameterSpec());
            byte[] decryptedBytes = encrypt.getCipher().doFinal(Base64.decodeBase64(encrypted));
            return new String(decryptedBytes, "UTF-8");
        }catch(Exception e){
        
        }
        return "";
    }
}
