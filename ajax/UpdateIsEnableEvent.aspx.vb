Imports Newtonsoft.Json
Imports System.Data
Imports DataConnection.DataAccessClassAsset
Partial Class ajax_UpdateIsEnableEvent
    Inherits System.Web.UI.Page

    Private Sub ajax_UpdateIsEnableEvent_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim id As String = Request.Form("id")
        Dim status As String = Request.Form("status")

        Try
            UpdateIsEnableEvent(id, Integer.Parse(status))
            Response.Write("Success")
        Catch ex As Exception
            Response.Write("fail")
        End Try
    End Sub
End Class
