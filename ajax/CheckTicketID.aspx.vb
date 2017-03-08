Imports System.Data
Imports Newtonsoft.Json
Imports System.IO
Imports System.Collections.Generic
Imports System.Exception
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Partial Class ajax_CheckTicketID
    Inherits System.Web.UI.Page

    Private Sub ajax_CheckTicketID_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim TicketId As String = Request.Form("tid")
        Dim dt As New DataTable
        dt = CheckIsAsset(TicketId)
        Dim dt2 As New DataTable
        dt2 = CheckIsSet(TicketId)


        Dim isAsset As Integer = Integer.Parse(dt.Rows(0)("cnt").ToString())

        Dim isSet As Integer = Integer.Parse(dt2.Rows(0)("cnt").ToString())

        If isAsset = 1 And isSet = 0 Then
            Response.Write("Success")
            Exit Sub
        ElseIf isAsset = 1 And isSet = 1 Then
            Response.Write("Is Set")
            Exit Sub
        ElseIf isAsset = 0 And isSet = 0 Then
            Response.Write("Not Found")
            Exit Sub
        End If

    End Sub
End Class
