﻿Imports System.Data
Imports System.Web.UI
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Imports Newtonsoft.Json
Partial Class ajax_Create5622
    Inherits System.Web.UI.Page

    Private Sub ajax_Create5622_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim para(2) As String
        para(0) = Request.QueryString("branch")
        para(1) = Request.QueryString("month")
        para(2) = Request.QueryString("year")

        Dim spara As Integer = para.Length

        'Response.Write(spara & ":" & para(0) & ":" & para(1))
        CrytalBuild.CreateReport("5622.rpt", para, spara)
    End Sub
End Class
