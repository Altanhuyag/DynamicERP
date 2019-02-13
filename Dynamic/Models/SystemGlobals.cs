using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Dynamic.Models
{
    public static class SystemGlobals
    {
        public static CDataBase DataBase;
        public static string HeaderTitleText = "";
        public static string FooterTitleText = "";
                
        public static string encrypt(string message)
        {
            byte[] results;
            UTF8Encoding utf8 = new UTF8Encoding();
            //UTF8Encoding  класс үүсгэнэ
            // MD5CryptoServiceProvider үүсгэ_э
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            byte[] deskey = md5.ComputeHash(utf8.GetBytes("MCE.B2E"));
            //passkey 2 т руу хөрвүүлнэ
            //TripleDESCryptoServiceProvider үүсгэнэ
            TripleDESCryptoServiceProvider desalg = new TripleDESCryptoServiceProvider();
            desalg.Key = deskey;//пасс encode хийх утгийг олгно
            desalg.Mode = CipherMode.ECB;
            desalg.Padding = System.Security.Cryptography.PaddingMode.PKCS7;
            byte[] encrypt_data = utf8.GetBytes(message);
            //UTF байт руу хөрвүүлнэ
            try
            {
                //md5 хөрвүүлнэ
                ICryptoTransform encryptor = desalg.CreateEncryptor();
                results = encryptor.TransformFinalBlock(encrypt_data, 0, encrypt_data.Length);

            }
            finally
            {
                //Санах ойг цэвэрлэнэ
                desalg.Clear();
                md5.Clear();
            }
            //64 bit ruu хөрвүүлнэ
            return Convert.ToBase64String(results);

        }

        public static string decrypt(string message)
        {
            byte[] results;
            UTF8Encoding utf8 = new UTF8Encoding();
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            byte[] deskey = md5.ComputeHash(utf8.GetBytes("MCE.B2E"));
            TripleDESCryptoServiceProvider desalg = new TripleDESCryptoServiceProvider();
            desalg.Key = deskey;
            desalg.Mode = CipherMode.ECB;
            desalg.Padding = System.Security.Cryptography.PaddingMode.PKCS7;
            byte[] decrypt_data = Convert.FromBase64String(message);
            try
            {
                //To transform the utf binary code to md5 decrypt
                ICryptoTransform decryptor = desalg.CreateDecryptor();
                results = decryptor.TransformFinalBlock(decrypt_data, 0, decrypt_data.Length);
            }
            finally
            {
                desalg.Clear();
                md5.Clear();

            }
            //TO convert decrypted binery code to string
            return utf8.GetString(results);
        }
    }
}