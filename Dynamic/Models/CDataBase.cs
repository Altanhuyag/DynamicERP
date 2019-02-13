// Decompiled with JetBrains decompiler
// Type: Shared.Library.CDataBase
// Assembly: IMCEControls 3.0, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 2FD48662-E543-4BE8-9C9B-2C79FB807969
// Assembly location: E:\Geganet Medical UPdate\IMCEControls 3.0.dll

using System;
using System.Collections;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Dynamic.Models
{
  public class CDataBase
  {
    private int _TimeOut = 30;
    private Hashtable tranList = new Hashtable();
    private string _ServerName;
    private string _DataBaseName;
    private string _UserName;
    private string _Password;
    private SqlCommand _MssqlCmd;

    public int TimeOut
    {
      get
      {
        return this._TimeOut;
      }
      set
      {
        this._TimeOut = value;
      }
    }

    public string ServerName
    {
      get
      {
        return this._ServerName;
      }
      set
      {
        this._ServerName = value;
      }
    }

    public string DataBaseName
    {
      get
      {
        return this._DataBaseName;
      }
      set
      {
        this._DataBaseName = value;
      }
    }

    public string UserName
    {
      get
      {
        return this._UserName;
      }
      set
      {
        this._UserName = value;
      }
    }

    public string Password
        {
            get
            {
                return this._Password;
            }
            set
            {
                this._Password = value;
            }
        }
            
    protected string ConnectionString
    {
      get
      {
        return "Data Source=" + this._ServerName + ";Initial Catalog=" + this._DataBaseName + ";User Id=" + this._UserName + ";Password=" + this._Password + ";connection timeout=" + (object) this._TimeOut + ";persist security info=True;";
      }
    }
            

    public SqlCommand MssqlCmd
    {
      get
      {
        return this._MssqlCmd;
      }
      set
      {
        this._MssqlCmd = value;
      }
    }


    public bool Open()
    {
      try
      {
        this.Close();
        this._MssqlCmd = new SqlCommand();
        this._MssqlCmd.Connection = new SqlConnection(this.ConnectionString);
        this._MssqlCmd.Connection.Open();
        return true;
      }
      catch (Exception ex)
      {
        throw ex;        
      }
    }

    public bool Close()
    {
      try
      {
        if (this._MssqlCmd != null)
        {
          if (this._MssqlCmd.Connection != null)
          {
            if (this._MssqlCmd.Connection.State != ConnectionState.Closed)
              this._MssqlCmd.Connection.Close();
            this._MssqlCmd.Connection = (SqlConnection) null;
          }
          if (this._MssqlCmd.Parameters != null)
            this._MssqlCmd.Parameters.Clear();
          this._MssqlCmd = (SqlCommand) null;
        }
        return true;
      }
      catch (Exception ex)
      {
                throw ex;
      }
    }
        
        

    public bool ExecuteNonQuery(string pModuleID, string pStoredName, string pXML)
    {
      return this.ExecuteNonQuery(pModuleID, pStoredName, pXML, 30);
    }

    public bool ExecuteNonQuery(string pModuleID, string pStoredName, string pXML, int TimeOut)
    {
      SqlCommand sqlCommand = (SqlCommand) null;
      try
      {        
        sqlCommand = new SqlCommand();
        sqlCommand.CommandText = pStoredName;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        SqlParameter sqlParameter1 = new SqlParameter();
        sqlParameter1.SqlDbType = SqlDbType.NText;
                sqlParameter1.Value = pXML;
        sqlParameter1.ParameterName = "@XML";
        sqlParameter1.Direction = ParameterDirection.Input;
        sqlCommand.Parameters.Add(sqlParameter1);
        if (pXML!="")
        {
          SqlParameter sqlParameter2 = new SqlParameter();
          sqlParameter2.SqlDbType = SqlDbType.TinyInt;
          sqlParameter2.Value = (object) 0;
          sqlParameter2.ParameterName = "@IntResult";
          sqlParameter2.Direction = ParameterDirection.Output;
          sqlCommand.Parameters.Add(sqlParameter2);
          SqlParameter sqlParameter3 = new SqlParameter();
          sqlParameter3.SqlDbType = SqlDbType.NVarChar;
          sqlParameter3.Value = (object) "";
          sqlParameter3.ParameterName = "@StrResult";
          sqlParameter3.Direction = ParameterDirection.Output;
          sqlCommand.Parameters.Add(sqlParameter3);
        }
        sqlCommand.CommandTimeout = TimeOut;
        sqlCommand.Connection = new SqlConnection(this.ConnectionString);
        if (sqlCommand.Connection.State == ConnectionState.Closed)
          sqlCommand.Connection.Open();
        sqlCommand.ExecuteNonQuery();
        return true;
      }
      catch (SqlException ex)
      {
                throw ex;
      }
      catch (Exception ex)
      {
                throw ex;
      }
      finally
      {
        if (sqlCommand.Connection.State != ConnectionState.Closed)
          sqlCommand.Connection.Close();
      }
    }

    public bool ExecuteNonQuery(string pModuleID, string pStoredName, SqlParameter[] pParams)
    {
      return this.ExecuteNonQuery(pModuleID, pStoredName, pParams, 30);
    }

    public bool ExecuteNonQuery(string pModuleID, string pStoredName, SqlParameter[] pParams, int TimeOut)
    {
      SqlCommand sqlCommand = (SqlCommand) null;
      try
      {        
        sqlCommand = new SqlCommand();
        sqlCommand.CommandText = pStoredName;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.Parameters.AddRange(pParams);
        sqlCommand.CommandTimeout = TimeOut;
        sqlCommand.Connection = new SqlConnection(this.ConnectionString);
        if (sqlCommand.Connection.State == ConnectionState.Closed)
          sqlCommand.Connection.Open();
        sqlCommand.ExecuteNonQuery();
        return true;
      }
      catch (SqlException ex)
      {
                throw ex;
      }
      catch (Exception ex)
      {
                throw ex;
      }
      finally
      {
        if (sqlCommand.Connection.State != ConnectionState.Closed)
          sqlCommand.Connection.Close();
      }
    }

    public object ExecuteQuery(string pStoredName, string pXML, ReturnObjectType retType)
    {
      return this.ExecuteQuery(pStoredName, (object) pXML, retType, 30);
    }

    public object ExecuteQuery(string pStoredName, object xmlOrParamOrRow, ReturnObjectType retType, int timeOut)
    {
      SqlCommand selectCommand = new SqlCommand();
      SqlDataAdapter sqlDataAdapter1 = (SqlDataAdapter) null;
      object obj1 = (object) null;
      try
      {        
        selectCommand.CommandText = pStoredName;
        selectCommand.CommandType = CommandType.StoredProcedure;
        if (xmlOrParamOrRow != null)
        {
          if (xmlOrParamOrRow.GetType() == typeof (string))
          {
            string str = (string) xmlOrParamOrRow;
            SqlParameter sqlParameter = new SqlParameter();
            sqlParameter.SqlDbType = SqlDbType.NText;
                        sqlParameter.Value = str;
            sqlParameter.ParameterName = "@XML";
            sqlParameter.Direction = ParameterDirection.Input;
            selectCommand.Parameters.Add(sqlParameter);
          }
          else if (xmlOrParamOrRow.GetType() == typeof (SqlParameter[]))
            selectCommand.Parameters.AddRange((SqlParameter[]) xmlOrParamOrRow);
          else if (xmlOrParamOrRow.GetType() == typeof (DataRow))
          {
            DataRow dataRow = (DataRow) xmlOrParamOrRow;
            int count = dataRow.Table.Columns.Count;
            for (int index = 0; index < count; ++index)
            {
              object obj2 = dataRow[index];
              SqlParameter sqlParameter = new SqlParameter("@" + dataRow.Table.Columns[index].ColumnName, obj2);
              selectCommand.Parameters.Add(sqlParameter);
            }
          }
        }
        selectCommand.CommandTimeout = timeOut;
        selectCommand.Connection = new SqlConnection(this.ConnectionString);
        if (selectCommand.Connection.State == ConnectionState.Closed)
          selectCommand.Connection.Open();
        if (retType == ReturnObjectType.Object)
          obj1 = selectCommand.ExecuteScalar();
        else if (retType == ReturnObjectType.NonQuery)
        {
          obj1 = (object) selectCommand.ExecuteNonQuery();
        }
        else
        {
          SqlDataAdapter sqlDataAdapter2 = new SqlDataAdapter(selectCommand);
          DataSet dataSet = new DataSet();
          sqlDataAdapter2.Fill(dataSet);
          try
          {
            switch (retType)
            {
              case ReturnObjectType.DataSet:
                obj1 = (object) dataSet;
                break;
              case ReturnObjectType.DataTable:
                obj1 = (object) dataSet.Tables[0];
                break;
              case ReturnObjectType.DataRow:
                obj1 = (object) dataSet.Tables[0].Rows[0];
                break;
            }
          }
          catch (Exception ex)
          {
            throw ex;
          }
        }
      }
      catch (SqlException ex)
      {
        throw ex;
      }
      catch (Exception ex)
      {
        throw ex;
      }
      finally
      {
        selectCommand.Parameters.Clear();
        if (selectCommand.Connection.State != ConnectionState.Closed)
          selectCommand.Connection.Close();
        sqlDataAdapter1 = (SqlDataAdapter) null;
      }
      return obj1;
    }

    public DataSet ExecuteQuery(string pStoredName)
    {
      return this.ExecuteQuery(pStoredName, "", 30);
    }

    public DataSet ExecuteQuery(string pStoredName, string pXML)
    {
      return this.ExecuteQuery(pStoredName, pXML, 30);
    }

    public DataSet ExecuteQuery(string pStoredName, string pXML, int TimeOut)
    {
      SqlCommand sqlCommand = (SqlCommand) null;
      SqlDataAdapter sqlDataAdapter1 = (SqlDataAdapter) null;
      DataSet dataSet = (DataSet) null;
      try
      {        
        sqlCommand = new SqlCommand();
        sqlCommand.CommandText = pStoredName;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        SqlParameter sqlParameter1 = new SqlParameter();
        sqlParameter1.SqlDbType = SqlDbType.NText;
        sqlParameter1.Value =pXML;
        sqlParameter1.ParameterName = "@XML";
        sqlParameter1.Direction = ParameterDirection.Input;
        sqlCommand.Parameters.Add(sqlParameter1);
        
          SqlParameter sqlParameter2 = new SqlParameter();
          sqlParameter2.SqlDbType = SqlDbType.TinyInt;
          sqlParameter2.Value = (object) 0;
          sqlParameter2.ParameterName = "@IntResult";
          sqlParameter2.Direction = ParameterDirection.Output;
          sqlCommand.Parameters.Add(sqlParameter2);
          SqlParameter sqlParameter3 = new SqlParameter();
          sqlParameter3.SqlDbType = SqlDbType.NVarChar;
          sqlParameter3.Value = (object) "";
          sqlParameter3.ParameterName = "@StrResult";
          sqlParameter3.Direction = ParameterDirection.Output;
          sqlCommand.Parameters.Add(sqlParameter3);
       
        SqlDataAdapter sqlDataAdapter2 = new SqlDataAdapter();
        dataSet = new DataSet();
        sqlCommand.CommandTimeout = TimeOut;
        sqlCommand.Connection = new SqlConnection(this.ConnectionString);
        if (sqlCommand.Connection.State == ConnectionState.Closed)
          sqlCommand.Connection.Open();
        sqlDataAdapter2.SelectCommand = sqlCommand;
        sqlDataAdapter2.Fill(dataSet);
      }
      catch (SqlException ex)
      {
                throw ex;
      }
      catch (Exception ex)
      {
                throw ex;
      }
      finally
      {
        if (sqlCommand.Connection.State != ConnectionState.Closed)
          sqlCommand.Connection.Close();
        sqlDataAdapter1 = (SqlDataAdapter) null;
      }
      return dataSet;
    }

    public DataSet ExecuteQuery( string pStoredName, SqlParameter[] pParams)
    {
      return this.ExecuteQuery(pStoredName, pParams, 30);
    }

    public DataSet ExecuteQuery( string pStoredName, SqlParameter[] pParams, int TimeOut)
    {
      SqlCommand sqlCommand = (SqlCommand) null;
      SqlDataAdapter sqlDataAdapter1 = (SqlDataAdapter) null;
      DataSet dataSet = (DataSet) null;
      try
      {        
        sqlCommand = new SqlCommand();
        sqlCommand.CommandText = pStoredName;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.Parameters.AddRange(pParams);
        SqlDataAdapter sqlDataAdapter2 = new SqlDataAdapter();
        dataSet = new DataSet();
        sqlCommand.CommandTimeout = TimeOut;
        sqlCommand.Connection = new SqlConnection(this.ConnectionString);
        if (sqlCommand.Connection.State == ConnectionState.Closed)
          sqlCommand.Connection.Open();
        sqlDataAdapter2.SelectCommand = sqlCommand;
        sqlDataAdapter2.Fill(dataSet);
      }
      catch (SqlException ex)
      {
                throw ex;
      }
      catch (Exception ex)
      {
                throw ex;
      }
      finally
      {
        if (sqlCommand.Connection.State != ConnectionState.Closed)
          sqlCommand.Connection.Close();
        sqlDataAdapter1 = (SqlDataAdapter) null;
      }
      return dataSet;
    }

    public DataSet ExecuteSQL(string pSQLStr)
    {
      return this.ExecuteSQL(pSQLStr, 30);
    }

    public DataSet ExecuteSQL(string pSQLStr, int TimeOut)
    {
      SqlCommand sqlCommand = (SqlCommand) null;
      SqlDataAdapter sqlDataAdapter1 = (SqlDataAdapter) null;      
      DataSet dataSet = (DataSet) null;
      try
      {
        sqlCommand = new SqlCommand();
        sqlCommand.CommandText = pSQLStr;
        sqlCommand.CommandType = CommandType.Text;
        SqlDataAdapter sqlDataAdapter2 = new SqlDataAdapter();
        dataSet = new DataSet();
        sqlCommand.CommandTimeout = TimeOut;
        sqlCommand.Connection = new SqlConnection(this.ConnectionString);
        if (sqlCommand.Connection.State == ConnectionState.Closed)
          sqlCommand.Connection.Open();
        sqlDataAdapter2.SelectCommand = sqlCommand;
        sqlDataAdapter2.Fill(dataSet);
      }
      catch (SqlException ex)
      {
                throw ex;
      }
      catch (Exception ex)
      {
                throw ex;
      }
      finally
      {
        if (sqlCommand.Connection.State != ConnectionState.Closed)
          sqlCommand.Connection.Close();
        sqlDataAdapter1 = (SqlDataAdapter) null;
      }
      return dataSet;
    }

   

    public bool ExecuteNonSQL(string pSQLStr)
    {
      return this.ExecuteNonSQL(pSQLStr, 30);
    }

        public bool ExecuteNonSQL(string pSQLStr, int TimeOut)
        {
            SqlCommand sqlCommand = (SqlCommand)null;
            try
            {
                sqlCommand = new SqlCommand();
                sqlCommand.CommandText = pSQLStr;
                sqlCommand.CommandType = CommandType.Text;
                sqlCommand.CommandTimeout = TimeOut;
                sqlCommand.Connection = new SqlConnection(this.ConnectionString);
                if (sqlCommand.Connection.State == ConnectionState.Closed)
                    sqlCommand.Connection.Open();
                sqlCommand.ExecuteNonQuery();
                return true;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (sqlCommand.Connection.State != ConnectionState.Closed)
                    sqlCommand.Connection.Close();
            }
        }
    
  }
}
