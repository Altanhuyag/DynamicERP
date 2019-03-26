using Dynamic.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace Dynamic
{
    /// <summary>
    /// Summary description for uploadfile
    /// </summary>
    public class uploadfile : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //string RestaurantMenuPkID = context.Request.QueryString["RestaurantMenuPkID"].ToString();
            //string ext = "asdf";
            //string XML = "<NewDataSet><BusinessObject><RestaurantMenuPkID>" + RestaurantMenuPkID + "</RestaurantMenuPkID><ImageFileExt>" + ext + "</ImageFileExt></BusinessObject></NewDataSet>";
            //SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantMenuImage_UPD", XML);

            if (context.Request.Files.Count > 0)
            {
                if (context.Request.QueryString["RestaurantMenuPkID"] != null)
                {
                    string RestaurantMenuPkID = context.Request.QueryString["RestaurantMenuPkID"].ToString();
                    HttpFileCollection UploadedFilesCollection = context.Request.Files;
                    for (int i = 0; i < UploadedFilesCollection.Count; i++)
                    {
                        string ext = Path.GetExtension(UploadedFilesCollection[i].FileName);

                        HttpPostedFile PostedFiles = UploadedFilesCollection[i];

                        string XML = "<NewDataSet><BusinessObject><RestaurantMenuPkID>" + RestaurantMenuPkID + "</RestaurantMenuPkID><ImageFileExt>" + ext + "</ImageFileExt></BusinessObject></NewDataSet>";
                        SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantMenuImage_UPD", XML);

                        string FilePath = context.Server.MapPath("/upload/menu/" + RestaurantMenuPkID + ext);

                        PostedFiles.SaveAs(FilePath);                       
                    }

                }

                if (context.Request.QueryString["RestaurantPkID"] != null)
                {
                    string RestaurantPkID = context.Request.QueryString["RestaurantPkID"].ToString();
                    HttpFileCollection UploadedFilesCollection = context.Request.Files;
                    for (int i = 0; i < UploadedFilesCollection.Count; i++)
                    {
                        string ext = Path.GetExtension(UploadedFilesCollection[i].FileName);

                        HttpPostedFile PostedFiles = UploadedFilesCollection[i];

                        string XML = "<NewDataSet><BusinessObject><RestaurantPkID>" + RestaurantPkID + "</RestaurantPkID><ImageFileExt>" + ext + "</ImageFileExt></BusinessObject></NewDataSet>";
                        SystemGlobals.DataBase.ExecuteQuery("spres_RestaurantImage_UPD", XML);

                        string FilePath = context.Server.MapPath("/upload/restaurant/" + RestaurantPkID + ext);

                        PostedFiles.SaveAs(FilePath);
                    }

                }

                if (context.Request.QueryString["DocumentPkID"] != null)
                {
                    string DocumentPkID = context.Request.QueryString["DocumentPkID"].ToString();
                    HttpFileCollection UploadedFilesCollection = context.Request.Files;
                    for (int i = 0; i < UploadedFilesCollection.Count; i++)
                    {
                        string ext = Path.GetExtension(UploadedFilesCollection[i].FileName);

                        HttpPostedFile PostedFiles = UploadedFilesCollection[i];

                        string XML = "<NewDataSet><BusinessObject><DocumentPkID>" + DocumentPkID + "</DocumentPkID><ImageFileExt>" + ext + "</ImageFileExt></BusinessObject></NewDataSet>";
                        SystemGlobals.DataBase.ExecuteQuery("spint_docDocumentImage_UPD", XML);

                        string FilePath = context.Server.MapPath("/upload/document/" + DocumentPkID + ext);

                        PostedFiles.SaveAs(FilePath);
                    }
                }

                if (context.Request.QueryString["CommentPkID"] != null)
                {
                    string CommentPkID = context.Request.QueryString["CommentPkID"].ToString();
                    HttpFileCollection UploadedFilesCollection = context.Request.Files;
                    for (int i = 0; i < UploadedFilesCollection.Count; i++)
                    {
                        string ext = Path.GetExtension(UploadedFilesCollection[i].FileName);

                        HttpPostedFile PostedFiles = UploadedFilesCollection[i];

                        string XML = "<NewDataSet><BusinessObject><CommentPkID>" + CommentPkID + "</CommentPkID><ImageFileExt>" + ext + "</ImageFileExt></BusinessObject></NewDataSet>";
                        SystemGlobals.DataBase.ExecuteQuery("spint_docDocumentCommentImage_UPD", XML);

                        string FilePath = context.Server.MapPath("/upload/document/comment/" + CommentPkID + ext);

                        PostedFiles.SaveAs(FilePath);
                    }
                }
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}