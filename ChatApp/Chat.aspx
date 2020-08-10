﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="ChatApp.Chat" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignalR Chat : Chat Page</title>

    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Content/style.css" rel="stylesheet" />
    <link href="Content/font-awesome.css" rel="stylesheet" />

    <script src="Scripts/jQuery-1.9.1.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.2.min.js"></script>
    <script src="Scripts/date.format.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="signalr/hubs"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" ></asp:ScriptManager>
        <div class="content-wrapper">

                   <header class="main-header" style="background:#bedaeb">
        <!-- Logo -->
        <a href="index2.html" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><b>SignalR</b> Chat App</span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
        
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- Messages: style can be found in dropdown.less-->

              <!-- User Account: style can be found in dropdown.less -->
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <img src="<%= UserImage %>" class="user-image" alt="User Image" />
                  <span class="hidden-xs"><%= this.UserName %></span>
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  <li class="user-header" >
                    <img src="<%= UserImage %>" class="img-circle" alt="User Image" />
                    <p style="color:#000000;">
                      <%= UserName %>
                    </p>
                  </li>
                  <!-- Menu Footer-->
                  <li class="user-footer">
                    <div class="pull-left">
                      <a  class="btn btn-default btn-flat" data-toggle="modal" href="#ChangePic">Change Picture</a>
                    </div>
                    <div class="pull-right">
                        <asp:Button ID="btnSignOut" runat="server" CssClass="btn btn-default btn-flat" Text="Sign Out" OnClick="btnSignOut_Click" />
                     <%-- <a href="#" class="btn btn-default btn-flat">Sign out</a>--%>
                    </div>
                  </li>
                </ul>
              </li>
              <!-- Control Sidebar Toggle Button -->

            </ul>
          </div>
        </nav>
      </header>

            <div class="row">

                <div class="col-md-8">
                    <!-- DIRECT CHAT PRIMARY -->
                    <div class="box box-primary direct-chat direct-chat-primary">
                       <div class="box-header with-border">
                            <h3 class="box-title" style="color:dimgrey;">Welcome to Discussion Room <span id='spanUser'></span></h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <!-- Conversations are loaded here -->
                                    <div class="box-body" id="chat-box">
                                            <!-- Conversations are loaded here -->

                                            <div id="divChatWindow" class="direct-chat-messages" style="height: 450px;">
                                            </div>

                                            <div class="direct-chat-contacts">
                                                <ul class="contacts-list" id="ContactList">

                                                    <!-- End Contact Item -->
                                                </ul>
                                                <!-- /.contatcts-list -->
                                            </div>
                                            <!-- /.direct-chat-pane -->
                                     
                                            </div>

                        </div>
                        <!-- /.box-body -->
                        <div class="box-footer">

                            <textarea id="txtMessage" class="form-control" ></textarea>

                            <div class="input-group" style="float: right;">
                                <input class="form-control" style="visibility: hidden;" />
                                <span class="input-group-btn">
                                    <input type="button" class="btn btn-primary btn-flat" id="btnSendMsg" value="send" />

                                </span>

                            </div>

                        </div>
                        <!-- /.box-footer-->
                    </div>
                    <!--/.direct-chat -->
                </div>
                <!-- /.col -->
                <div class="col-md-4">

                    <div class="box box-solid box-primary">

                        <div class="box-header with-border">
                            <h3 class="box-title">Online Users <span id='UserCount'></span></h3>
                        </div>

                        <div class="box-footer box-comments" id="divusers">
                        </div>

                    </div>
                </div>

                <!-- /.col -->


                <!-- /.col -->

                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>

        <span id="time"></span>
        <input id="hdId" type="hidden" />
        <input id="PWCount" type="hidden" value="info" />
        <input id="hdUserName" type="hidden" />

          <div class="modal fade" id="ChangePic" role="dialog">
        <div class="modal-dialog" style="width: 700px">
            <div class="modal-content">
                <div class="modal-header bg-light-blue-gradient with-border">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Change Profile Picture</h4>
                </div>
                <div class="modal-body">
                    <div class="container">

                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                   
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnChangePicModel" />
                        </Triggers>
                        <ContentTemplate>

                        <div class="row">
                            <div class="col-md-12">
                                <table class="table table-bordered table-striped table-hover table-responsive" style="width: 600px">

                                    <tr>

                                        <div class="col-md-12">
                                            <td class="text-primary col-md-4" style="font-weight: bold;">
                                                <img id="ImgDisp" src="" class="user-image" style="height: 100px;" />
                                            </td>
                                            <td class="text-primary col-md-4" style="font-weight: bold;">
                                                <asp:FileUpload ID="FileUpload1" runat="server" class="btn btn-default"/>
                                            </td>
                                            <td class="col-md-4">
                                                
                                              <asp:Button ID="btnChangePicModel" runat="server" Text="Update Picture" CssClass="btn btn-flat btn-success" OnClick="btnChangePicModel_Click" />

                                                   
                                            </td>
                                        </div>

                                    </tr>


                                    <tr>
                                        <div class="col-md-12">

                                            <td class="col-md-12" colspan="4"></td>
                                        </div>

                                    </tr>


                                </table>
                            </div>
                        </div>

                    </div>
                </div>
                 </ContentTemplate>
                  </asp:UpdatePanel>
            </div>
        </div>
    </div>
            </div>
          </div>

         <script src="Scripts/bootstrap.min.js"></script>

    </form>
</body>
</html>

