using ChatApp.Data;
using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ChatApp
{
    public class ChatHub : Hub
    {
        static List<Users> connectedUsers = new List<Users>();
        static List<Messages> currentMessages = new List<Messages>();
        Conn conn = new Conn();

        public void Connect(string userName)
        {
            var id = Context.ConnectionId;

            if (connectedUsers.Count(x => x.ConnectionId == id) == 0)
            {
                string userImg = GetUserImage(userName);
                string loginTime = DateTime.Now.ToString();
                connectedUsers.Add(new Users
                {
                    ConnectionId = id,
                    UserName = userName,
                    UserImage = userImg,
                    LoginTime = loginTime
                });

                //send to caller
                Clients.Caller.onConnected(id, userName, userImg, loginTime);

                // send to all except caller client
                Clients.AllExcept(id).onNewUserConnected(id, userName, userImg, loginTime);
            
            }

        }

        public void SendMessageToAll(string userName, string message, string time)
        {
            string userImg = GetUserImage(userName);
            //store last 100 messages in cache
            AddMessageinCache(userName, message, time, userImg);
        }

        public void AddMessageinCache(string userName, string message, string time, string userImg)
        {
            currentMessages.Add(new Messages
            {
                UserName = userName,
                Message = message,
                Time = time,
                UserImage = userImg
            });

            if (currentMessages.Count > 100)
                currentMessages.RemoveAt(0);
        }

        public string GetUserImage(string userName)
        {
            string image = "images/profil.jpg";

            try
            {
                string query = "select Photo from tbl_Users where UserName='" + userName + "'";
                string imageName = conn.GetColumnVal(query, "Photo");

                if (imageName != "")
                {
                    image = "images/" + imageName;
                }
            }
            catch (Exception)
            {

               
            }
            return image;    
        }
    }
}