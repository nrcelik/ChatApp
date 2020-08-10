using ChatApp.Data;
using System;
using System.Web.UI;

namespace ChatApp
{
    public partial class Register : System.Web.UI.Page
    {
        Conn conn = new Conn();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnRegister_ServerClick(object sender, EventArgs e)
        {
            string Query = "insert into tbl_Users(UserName,Email,Password)Values('" + txtName.Value + "','" + txtEmail.Value + "','" + txtPassword.Value + "')";
            string ExistQ = "select * from tbl_Users where Email='" + txtEmail.Value + "'";

            if (!conn.IsExist(ExistQ))
            {
                if (conn.ExecuteQuery(Query))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Message", "alert('Congratulations!! You have successfully registered..');", true);
                    Session["UserName"] = txtName.Value;
                    Session["Email"] = txtEmail.Value;
                    Response.Redirect("Chat.aspx");
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Message", "alert('Email is already Exists!! Please Try Different Email..');", true);
            }
        }
    }

}