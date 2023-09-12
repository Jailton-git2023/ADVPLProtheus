#include 'protheus.ch'
#include 'parmtype.ch'

user function Mvc_br1()

oBrowse:=FWMBROWSE():NEW()
oBrowse:SetAlias("SA1")
oBrowse:SetDescription("Clientes")
//oBrowse:Activate()

//Definição da legenda

oBrowse:addlegend("A1_TIPO=='F'","YELLOW","Consumidor final")
oBrowse:addlegend("A1_TIPO=='L'","BLUE","Produtor rural")
obrowse:addlegend("A1_TIPO=='R'","RED","Revendedor")
obrowse:addlegend("A1_TIPO=='S'","ORANGE","Solidário")
obrowse:addlegend("A1_TIPO=='X'","GREEN","Exportação")

//oBrowse:Activate()

//Filtros de um browse

//oBrowse:SetfilterDefault("A1_TIPO=='F'")

oBrowse:Activate()


return

Static Function ModelDef() 
//Aqui são definidas as regras de negócio ou modelo de dados (model)
//Contém - Entidades envolvidas
//Validações, relacionamentos, persistência de dados gravação.

Local oModel //Modelo de dados que será construído.
			//Construindo o modelo.
//Cria o objeto do modelo de dados.
oModel:=MPFormModel():New('COMP011M') //MPFormModel é a classe utilizada para a
										//construção de um objeto de modelo de dados(model).
//Cria a estrutura a ser usada no modelo de dados.
Local oStruSA1:=FWFormStruct(1,'SA1')

//Adiciona ao modelo um componente de formulário.
oModel:AddFields('SA1MASTER', /*cOwner*/, oStrucSA1)

//Adiciona a descrição do modelo de dados
oModel:SetDescription('Modelo de dados de clientes')

//Adiciona a descrição do componente do modelo de dados
oModel:GetModel('SA1MASTER'):SetDescription('Dados do cliente')

//Retorna o modelo de dados

Return oModel

//--------------------------------------

Static Function ViewDef()

//Cria um objeto de modelo de dados baseado no Modeldef() do fonte informado.
Local oModel:=FWLoadModel('Mvc_br1')
//Cria a estrutura a ser usada na view.
Local oStruSA1:=FWForStruct(2,'SA1')
//Interface de visualização construída.
Local oView
//Cria o objeto da View
oView:FWForView():New()
//Define qual o modelo de dados será utilizado na View.
oView:SetModel(oModel)
//Adiciona no nosso View um controle do tipo formulário.
//Antiga Enchoice)
oView:AddField('VIEW_SA1', oStruSA1,'SA1MASTER')
)//Cria um "box" horizontal para receber algum elemento da view.
oView:CreateHorizontalBox('TELA', 100)
//Relaciona o identificador (ID) da view com o "box" para exibição.
oView:SetOwnerView('VIEW_SA1', 'TELA')
//Retorna o objeto de View criado.
Return oView







Static Function MenuDef()

//Return(FWMVCMENU('CADICLI')) // inclui no menu os botões de incluir, alterar e etc.
Local aRotina:={}

ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.COMP011_MVC' OPERATION 2
ADD OPTION aRotina TITLE 'Legenda'    ACTION 'u_zMVC01Leg'     OPERATION 6                      ACCESS 0 //OPERATION X
ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.COMP011_MVC' OPERATION 3
ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.zMVCMd1' OPERATION 4
ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.zMVCMd1' OPERATION 5
 
Return aRotina





