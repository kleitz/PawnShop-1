Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports Newtonsoft.Json
Partial Class ajax_UpdateTray
    Inherits System.Web.UI.Page

    Private Sub ajax_UpdateTray_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim id As String = Request.Form("id")

        Try
            UpdateTrayToZero(id)
            Response.Write("Success")
        Catch ex As Exception
            Response.Write("fail")
        End Try

    End Sub
End Class
