Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Partial Class Main
    Inherits System.Web.UI.Page

    Private Sub Main_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim UserName As String = "TOT00"
        Dim UserPwd As String = "1234"

        'coment จากนี้
        'Dim UserName As String = "Pairoj"
        'Dim UserPwd As String = "1111"

        Dim UserIPAddr As String = WebUtilFn.GetClientIPAddress(Request)
        Dim tokenObj As New PSCS.Libary.Models.TokenClass
        Dim pwsObj As New PawnWSShopService.PawnShopServices

        'session_username = "TOT00"
        'session_roleid = 2
        'session_branchID = 18

        Dim retJSONStr As String = pwsObj.GetToken(UserName, UserPwd, UserIPAddr)
        tokenObj = Newtonsoft.Json.JsonConvert.DeserializeObject(Of PSCS.Libary.Models.TokenClass)(retJSONStr)
        PawnUtilFn.SetSessionUserObj(tokenObj)

        '-----
        'ถึงนี้

        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        If Not PawnUtilFn.GetSessionUserObj(tokenOb) Then
            Response.Redirect("../../../login.aspx")
            Exit Sub
        End If


        Dim RoleID As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).RoleId



        hiddenRole.Value = RoleID



    End Sub
End Class
