#Include "Protheus.ch"
 
User Function LeArqTxt()

Private nOpc      	:= 0
Private cCadastro 	:= "Ler arquivo texto"
Private aSay      	:= {}
Private aButton   	:= {}

aAdd( aSay, "O objetivo desta rotina e efetuar a leitura em um arquivo texto" )

aAdd( aButton, { 1,.T.,{|| nOpc := 1,FechaBatch()}})
aAdd( aButton, { 2,.T.,{|| FechaBatch() }} )

FormBatch( cCadastro, aSay, aButton )

If nOpc == 1
	Processa( {|| Import() }, "Processando..." )
EndIf

Return Nil

Static Function Import()

Local cBuffer   	:= ""
Local cFileOpen 	:= ""
Local cTitulo1  	:= "Selecione o arquivo"
Local cExtens   	:= "Arquivo TXT | *.txt"

Private cMainPath := ""

//Usar o arquivo expsa1 gerado pelo fonte anterior.
/***
 * _________________________________________________________
 * cGetFile(<ExpC1>,<ExpC2>,<ExpN1>,<ExpC3>,<ExpL1>,<ExpN2>)
 * ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 * <ExpC1> - Expressão de filtro
 * <ExpC2> - Titulo da janela
 * <ExpN1> - Numero de mascara default 1 para *.Exe
 * <ExpC3> - Diretório inicial se necessário
 * <ExpL1> - .F. botão salvar - .T. botão abrir
 * <ExpN2> - Mascara de bits para escolher as opções de visualização do objeto
 * (prconst.ch)
 */
cFileOpen := cGetFile(cExtens,cTitulo1,,cMainPath,.T.)

If !File(cFileOpen)
   MsgAlert("Arquivo texto: "+cFileOpen+" não localizado",cCadastro)
   Return
Endif

FT_FUSE(cFileOpen)  //ABRIR
FT_FGOTOP() //PONTO NO TOPO

ProcRegua(FT_FLASTREC()) //QTOS REGISTROS LER

While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
   IncProc()

   // Capturar dados
   cBuffer := FT_FREADLN() //LENDO LINHA 
   
   cMsg := "Filial: "		+SubStr(cBuffer,01,02) + Chr(13)+Chr(10)
   cMsg += "Código: "   	+SubStr(cBuffer,03,06) + Chr(13)+Chr(10)
   cMsg += "Loja: "  		+SubStr(cBuffer,09,02) + Chr(13)+Chr(10)
   cMsg += "Nome fantasia: " 	+SubStr(cBuffer,11,15) + Chr(13)+Chr(10)
   cMsg += "Valor: "   	     	+SubStr(cBuffer,26,14) + Chr(13)+Chr(10)
   cMsg += "Data: "          	+SubStr(cBuffer,40,08) + Chr(13)+Chr(10)
  
   MsgInfo(cMsg)
   
   FT_FSKIP()   //próximo registro no arquivo txt
EndDo

FT_FUSE() //fecha o arquivo txt

MsgInfo("Processo finalizada")

Return Nil