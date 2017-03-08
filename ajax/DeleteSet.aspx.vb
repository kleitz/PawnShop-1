Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports System.IO
Imports Newtonsoft.Json
Partial Class ajax_DeleteSet
    Inherits System.Web.UI.Page

    Private Sub ajax_DeleteSet_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim id As String = Request.Form("SetID")
        Try
            UpdateSetToZero(id)
            UpdateChildToZero(id)
            Response.Write("Success")
        Catch ex As Exception
            Response.Write("fail")
        End Try
    End Sub
End Class
