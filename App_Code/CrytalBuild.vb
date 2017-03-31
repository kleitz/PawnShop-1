Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports CrystalDecisions.Web.Design

Imports System.IO
Imports System.Web
Imports System.Web.UI.Page
Public Class CrytalBuild

    Public Shared Sub CreateReport(ByVal sReport As String, ByVal aPara As Array, ByVal sPara As Integer,
                                Optional ByVal DoParams As Boolean = True)
        Dim oRpt As New ReportDocument
        Dim oSubRpt As New ReportDocument
        Dim Counter As Integer
        Dim crSections As Sections

        Dim crDatabase As Database
        Dim crTables As Tables
        Dim crTable As Table
        Dim crLogOnInfo As TableLogOnInfo
        Dim crConnInfo As New ConnectionInfo
        Dim crParameterValues As ParameterValues
        Dim crParameterDiscreteValue As ParameterDiscreteValue
        Dim crParameterRangeValue As ParameterRangeValue
        Dim crParameterFieldDefinitions As ParameterFieldDefinitions
        Dim crParameterFieldDefinition As ParameterFieldDefinition


        Dim tstr As String

        Dim sReportPath As String = HttpContext.Current.Request.ServerVariables _
       ("APPL_PHYSICAL_PATH") &
       "\CrystalReport\" & sReport


        Try
            tstr = Microsoft.VisualBasic.Format(Now, "MM/dd/yyyy HH:mm:ss")

            oRpt.Load(sReportPath)

            crDatabase = oRpt.Database
            crTables = crDatabase.Tables





            For Each crTable In crTables
                With crConnInfo
                    .ServerName = "180.180.247.22/PawnShop"
                    .DatabaseName = "PawnShop"
                    .UserID = "TOT"
                    .Password = "root"
                End With
                crLogOnInfo = crTable.LogOnInfo
                crLogOnInfo.ConnectionInfo = crConnInfo
                crTable.ApplyLogOnInfo(crLogOnInfo)
            Next
            crSections = oRpt.ReportDefinition.Sections

            If DoParams Then

                crParameterFieldDefinitions = oRpt.DataDefinition.ParameterFields()


                For Counter = 0 To UBound(aPara)

                    If Counter <= sPara Then  'counter equal para(3) - 1 because counter begin 0
                        crParameterFieldDefinition =
                        crParameterFieldDefinitions.Item(Counter)

                        crParameterValues = crParameterFieldDefinition.CurrentValues

                        If Not IsArray(aPara(Counter)) Then

                            crParameterDiscreteValue = New ParameterDiscreteValue
                            crParameterDiscreteValue.Value = aPara(Counter)

                            crParameterValues.Add(crParameterDiscreteValue)

                            HttpContext.Current.Response.Write("<br /> 00 crParameterValues = " & aPara(Counter).ToString())
                        Else

                            crParameterRangeValue = New ParameterRangeValue
                            crParameterRangeValue.StartValue = aPara(Counter)(0)
                            crParameterRangeValue.EndValue = aPara(Counter)(1)
                            crParameterValues.Add(crParameterRangeValue)

                            HttpContext.Current.Response.Write("<br /> crParameterValues = " & crParameterValues.ToString())
                        End If

                        crParameterFieldDefinition.ApplyCurrentValues(crParameterValues)

                    End If

                Next



            End If

            Dim oStream As System.IO.Stream
            oStream = oRpt.ExportToStream(ExportFormatType.PortableDocFormat)
            Dim len As Int64 = oStream.Length
            Dim byteArray(len) As Byte
            oStream.Read(byteArray, 0, Convert.ToInt64(oStream.Length - 1))

            With HttpContext.Current.Response
                .ClearContent()
                .ClearHeaders()
                .ContentType = "application/pdf"
                .BinaryWrite(byteArray)
                .Flush()
                .Close()
            End With

            oRpt.Close()
            oRpt.Dispose()

        Catch ex As System.Exception

            HttpContext.Current.Response.Write("<br /> error = " & ex.ToString())

        Finally
            Erase aPara
        End Try
    End Sub


End Class
