Imports Newtonsoft.Json
Imports PSCS.Libary.Models
Imports System.Data
Imports DataConnection.DataAccessClassAsset
Partial Class ajax_DeleteChild
    Inherits System.Web.UI.Page

    Private Sub ajax_DeleteChild_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        If Not PawnUtilFn.GetSessionUserObj(tokenOb) Then
            Response.Redirect("../../../login.aspx")
            Exit Sub
        End If

        'Dim RoleId As Integer = tokenOb.RoleId

        'Dim BranchId As Integer = tokenOb.BranchId

        Dim setID As String = Request.Form("SetID")
        Dim ticketId As String = Request.Form("TicketID")

        Try
            UpdateChildDetail(setID, ticketId)
            Response.Write("Success")
        Catch ex As Exception
            Response.Write("fail")
        End Try
    End Sub
End Class
