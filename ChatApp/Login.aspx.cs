using ChatApp.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ChatApp
{
    public partial class Login : System.Web.UI.Page
    {
        Conn conn = new Conn();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            string Query = "select * from tbl_Users where Email='" + txtEmail.Value + "' and Password='" + txtPassword.Value + "'";
            if (conn.IsExist(Query))
            {
                string UserName = conn.GetColumnVal(Query, "UserName");
                Session["UserName"] = UserName;
                Session["Email"] = txtEmail.Value;
                Response.Redirect("Chat.aspx");
            }
            else
                txtEmail.Value = "Invalid Email or Password!!";
        }
    }
}