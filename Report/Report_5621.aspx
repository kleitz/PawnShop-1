<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Report_5621.aspx.vb" Inherits="Report_5621" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <center><h3>บัญชีประเมินราคาทรัพย์หลุดเป็นกรรมสิทธิ์</h3></center>
    <div>
        สาขา :<asp:DropDownList ID="ddlBranch" runat="server"></asp:DropDownList>
        <br />
        <br />
        ปี :<asp:DropDownList ID="ddlYear" runat="server" 
            AutoPostBack="True"></asp:DropDownList>
        เดือน :<asp:DropDownList ID="ddlMonth" runat="server" AutoPostBack="True">
            <asp:ListItem Value="01">มกราคม</asp:ListItem>
            <asp:ListItem Value="02">กุมภาพันธ์</asp:ListItem>
            <asp:ListItem Value="03">มีนาคม</asp:ListItem>
            <asp:ListItem Value="04">เมษายน</asp:ListItem>
            <asp:ListItem Value="05">พฤษภาคม</asp:ListItem>
            <asp:ListItem Value="06">มิถุนายน</asp:ListItem>
            <asp:ListItem Value="07">กรกฎาคม</asp:ListItem>
            <asp:ListItem Value="08">สิงหาคม</asp:ListItem>
            <asp:ListItem Value="09">กันยายน</asp:ListItem>
            <asp:ListItem Value="10">ตุลาคม</asp:ListItem>
            <asp:ListItem Value="11">พฤษจิกายน</asp:ListItem>
            <asp:ListItem Value="12">ธันวาคม</asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        งวดที่ :<asp:DropDownList ID="ddlPeriodNo" runat="server" ></asp:DropDownList>

        <br />
        <br />
        <asp:Button ID="SubmitReport" runat="server" Text="ออกรายงาน" />
    </div>
    </form>
</body>
</html>
