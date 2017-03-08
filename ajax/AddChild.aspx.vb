Imports Newtonsoft.Json
Imports System.Data
Imports DataConnection.DataAccessClassAsset
Imports PSCS.Libary.Models
Partial Class ajax_AddChild
    Inherits System.Web.UI.Page

    Private Sub ajax_AddChild_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        'Dim tokenID As String = CStr(tokenOb.TokenId)
        'Dim BranchId As Integer = CType(Session(WebConstant.SessionName_UserObj), TokenClass).BranchId
        'Dim Emid As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).PrivateCode
        Dim Username As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).UserName

        Dim SetID As String = Request.Form("SetID")
        Dim TicketId As String = Request.Form("TicketId")

        Try
            InsertSetChild(SetID, TicketId, Username)
            Response.Write("Success")
        Catch ex As Exception
            Response.Write("fail")
        End Try

    End Sub
End Class
