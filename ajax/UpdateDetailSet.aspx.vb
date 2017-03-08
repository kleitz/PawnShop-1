Imports System.Data
Imports Newtonsoft.Json
Imports System.IO
Imports System.Collections.Generic
Imports System.Exception
Imports PSCS.Libary.Models
Imports DataConnection.DataAccessClassAsset
Partial Class ajax_UpdateDetailSet
    Inherits System.Web.UI.Page

    Private Sub ajax_UpdateDetailSet_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tokenOb As New PSCS.Libary.Models.TokenClass
        Dim tokenID As String = CStr(tokenOb.TokenId)
        Dim BranchId As Integer = CType(Session(WebConstant.SessionName_UserObj), TokenClass).BranchId

        Dim RoleID As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).RoleId

        Dim Username As String = CType(Session(WebConstant.SessionName_UserObj), TokenClass).UserName

        Dim json As String
        Using reader = New StreamReader(Request.InputStream)
            json = reader.ReadToEnd()
        End Using

        Dim data As SetEdit = JsonConvert.DeserializeObject(Of SetEdit)(json)
        Dim SetID As String = data.SetID
        Dim Weight As Decimal = data.Weight
        Dim PriceSum As Decimal = data.PriceSum
        Dim PriceEstimate As Decimal = data.PriceEstimate

        Try
            UpdateSetDetail(SetID, Weight, PriceSum, PriceEstimate)
            Response.Write("Success")
        Catch ex As Exception
            Response.Write("fail")
        End Try

    End Sub
End Class
