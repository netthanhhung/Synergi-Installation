<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Log.aspx.cs" Inherits="Planet.Rockford.TimeClock.Web.UI.Log" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <title>Synergi - Log Page</title>
    <style type="text/css">
        body { background: white; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div id="divlogin" runat="server">
            <p>Please enter a code for viewing this page</p>
            <asp:Label ID="lblMessage" ForeColor="Red" runat="server" /><br />
            <asp:TextBox ID="txtPassword" Width="400px" TextMode="MultiLine" Rows="5" runat="server" /><br />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
        </div>
        <div id="divFilter" runat="server" visible="false">
            <asp:Label ID="Label1" runat="server" Text="Number of Records:" />
            <asp:TextBox ID="txtNbrItems" Width="50px" runat="server" />
            <asp:Button ID="btnLoad" runat="server" Text="Load" />
        </div>
        <div>
            <asp:gridview AutoGenerateColumns="false" ID="gridLog" runat="server">
                <Columns>
                  <asp:TemplateField HeaderText="Number" ItemStyle-HorizontalAlign="Center">
                     <ItemTemplate>
                           <%# Container.DataItemIndex + 1 %>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Text">
                     <ItemTemplate>
                        <%#Container.DataItem %>
                     </ItemTemplate>
                </asp:TemplateField>
                </Columns>
            </asp:gridview>
        </div>
    </div>
    </form>
</body>
</html>
