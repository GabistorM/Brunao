use  master
go

drop database Locadora
go


/*
A ideia aqui é treinar todos os conceitos aprendidos
	crud
	trigger
	view
	procedure
	function entender melhor como funciona
	tentar colocar uma funcao dentro da outra


Vou criar um BD de uma locadora de carros
ela deve conter todos os carros (Marca, modelo, preço)
na tabela de aluguel deve conter (valor do aluguel - que devera ser uma equação - localizaçao do veiculo)

*/

/*
1º	Fiat Strada	120.600	10.573
2º	Volkswagen Polo	111.242	17.999
3º	Chevrolet Onix	102.043	10.839
4º	Hyundai HB20	88.905	9.627
5º	Chevrolet Onix Plus	74.887	6.375
6º	Fiat Mobi	73.428	7.395
7º	Volkswagen T-Cross	72.441	7.792
8º	Fiat Argo	66.717	5.218
9º	Chevrolet Tracker	66.643	6.769
10º	Hyundai Creta	65.817	8.579
11º	Renault Kwid	63.317	8.104
12º	Jeep Compass	59.106	3.937
13º	Volkswagen Nivus	52.103	5.646
14º	Fiat Toro	51.303	4.708
15º	Nissan Kicks	50.778	4.820
16º	Honda HR-V	48.054	4.201
17º	Jeep Renegade	47.389	3.234
18º	Volkswagen Saveiro	46.600	5.283
19º	Toyota Hilux	46.200	4.344
20º	Fiat Pulse	45.808	4.357
21º	Toyota Corolla	42.925	4.050
22º	Toyota Corolla Cross	42.071	4.390
23º	Fiat Fastback	40.404	3.949
24º	Hyundai HB20S	30.281	3.035
25º	Chevrolet Montana	30.018	2.483
26º	Peugeot 208	28.629	2.636
27º	Volkswagen Virtus	27.094	3.629
28º	Citroën C3	26.578	2.020
29º	Renault Duster	26.506	3.175
30º	Chevrolet S10	25.967	3.133
31º	Toyota Yaris	23.339	2.762
32º	Fiat Fiorino	21.864	3.485
33º	Toyota Yaris Sedan	20.571	2.702
34º	Ford Ranger	20.353	2.451
35º	Chevrolet Spin	20.314	1.814
36º	Jeep Commander	19.874	1.185
37º	Toyota SW4	16.006	1.922
38º	Volkswagen Taos	15.986	1.761
39º	Caoa Chery Tiggo 5X	14.400	2.225
40º	Renault Oroch	12.734	1.359
41º	Mitsubishi L200 Triton	12.644	1.821
42º	Honda City	11.842	931
43º	Honda City Hatch	10.802	813
44º	GWM Haval H6	10.704	2.085
45º	Renault Master	10.611	1.133
46º	Caoa Chery Tiggo 8	9.545	1.155
47º	Nissan Versa	8.859	1.024
48º	Ram Rampage	8.637	2.490
49º	Nissan Frontier	8.388	1.024
50º	Volkswagen Amarok	7.978	699
*/


			-- Criação do database
create database Locadora
go

use Locadora
go


			-- criação da primeira tabela 

create table Carros
	(
		CarId			int						not null			identity			primary key,
		Marca			varchar (50)			not null,
		Modelo		varchar (50)			not null,
		Valor			varchar (10)
	)
go

			-- criação da segunda tabela

create table Localizacao
	(
		LocId			int							not null			identity			primary key,
		Estado			varchar (2)				not null,
		Cidade			varchar (100)			not null
	)
go

			-- criação da terceira tabela

create table Cliente
	(
		CliId				int							not null			identity			primary key,
		Nome			varchar (100)			not null,
		Estado			varchar (2)				not null,
		Cidade			varchar (100)			not null,
		Bairro			varchar (100)			not null,
		Rua				varchar (100)			not null,
		Numero		int
	)
go

		-- criação da quarta tabela 

create table Aluguel
	(
		IdCli				int			not null,
		IdCar			int			not null,
		IdLoc			int			not null,
		QtdDias		int			not null,


			primary key (IdCli, IdCar, IdLoc),
				foreign key (IdCli) references Cliente (CliId),
				foreign key (IdCar) references Carros (CarId),
				foreign key (IdLoc) references Localizacao (LocId)
	)
go

			-- Criar um (if) depois para dar descuntos quando os dias passarem de uma quantidade expecifica

/*
	cadastrar 
	primeiro usar uma procedure para cadastrar os carros ( usar uma trigger para determinar o valor do aluguel) - com trigger nao da
	depois uma view para trazer os carros cadastrados 
	tentar usar usar uma function

	*/

create or alter  procedure spCadCarros

		(
		@Marca			varchar (50),
		@Modelo			varchar (50),
		@Valor				varchar (10)
		)
	as
		begin
			insert into Carros (Marca, Modelo, Valor)
				values (@Marca, @Modelo,  @Valor)
		end
go

exec spCadCarros
	'Fiat', 'Strada',	'R$ 120.600'
exec spCadCarros
	'Volkswagen', 'Polo	', 'R$111.242'
exec spCadCarros
	'Chevrolet', 'Onix',	'R$102.043'	
exec spCadCarros
	'Hyundai','HB20', 'R$88.905'
exec spCadCarros
	'Chevrolet', 'Onix Plus',	'R$74.887'
exec spCadCarros
	'Fiat', 'Mobi',	'R$73.428'
exec spCadCarros
	'Volkswagen', 'T-Cross','R$72.441'
exec spCadCarros
	'Fiat', 'Argo',	'R$66.717'
exec spCadCarros
	'Chevrolet', 'Tracker', 'R$66.643'
exec spCadCarros
	'Hyundai', 'Creta', 'R$65.817'
exec spCadCarros
	'Renault', 'Kwid', 'R$63.317'
exec spCadCarros
	'Jeep', 'Compass', 'R$59.106'
exec spCadCarros
	'Volkswagen', 'Nivus', 'R$52.103'
exec spCadCarros
	'Fiat', 'Toro',	'R$51.303'
exec spCadCarros
	'Nissan', 'Kicks',	'R$50.778'
exec spCadCarros
	'Honda', 'HR-V',	'R$48.054'
exec spCadCarros
	'Jeep', 'Renegade', 'R$47.389'
exec spCadCarros
	'Volkswagen', 'Saveiro', 'R$46.600'
exec spCadCarros
	'Toyota', 'Hilux', 'R$46.200'
exec spCadCarros
	'Fiat', 'Pulse',	'R$45.808'
exec spCadCarros
	'Toyota', 'Corolla',	'R$42.925'
exec spCadCarros
	'Toyota', 'Corolla Cross', 'R$42.071'
exec spCadCarros
	'Fiat', 'Fastback', 'R$40.404'
exec spCadCarros
	'Hyundai', 'HB20S', 'R$30.281'
exec spCadCarros
	'Chevrolet', 'Montana', 'R$30.018'
exec spCadCarros
	'Peugeot', '208',	'R$280.629'
exec spCadCarros
	'Volkswagen', 'Virtus', 'R$270.094'
exec spCadCarros
	'Citroën', 'C3', 'R$260.578'
exec spCadCarros
	'Renault', 'Duster',	 'R$260.506'
exec spCadCarros
	'Chevrolet', 'S10', 'R$250.967'
exec spCadCarros
	'Toyota', 'Yaris', 'R$230.339'
exec spCadCarros
	'Fiat', 'Fiorino', 'R$210.864'
exec spCadCarros
	'Toyota', 'Yaris Sedan',	'R$200.571'
exec spCadCarros
	'Ford', 'Ranger',	'R$200.353'
exec spCadCarros
	'Chevrolet', 'Spin',	'R$20.314'
exec spCadCarros
	'Jeep', 'Commander',	'R$190.874'
exec spCadCarros
	'Toyota', 'SW4', 'R$160.006'
exec spCadCarros
	'Volkswagen', 'Taos',	'R$150.986'
exec spCadCarros
	'Caoa', 'Chery Tiggo 5X', 'R$140.400'
exec spCadCarros
	'Renault', 'Oroch',	'R$120.734'
exec spCadCarros
	'Mitsubishi', 'L200 Triton',	'R$120.644'
exec spCadCarros
	'Honda', 'City', 'R$110.842'
exec spCadCarros
	'Honda', 'City Hatch',	'R$100.802'
exec spCadCarros
	'GWM', 'Haval H6',  'R$100.704'
exec spCadCarros
	'Renault', 'Master', 'R$100.611'
exec spCadCarros
	'Caoa', 'Chery Tiggo 8',	'R$90.545'
exec spCadCarros
	'Nissan', 'Versa', 'R$80.859'
exec spCadCarros
	'Ram', 'Rampage', 'R$80.637'
exec spCadCarros
	'Nissan', 'Frontier', 'R$80.388'
exec spCadCarros
	'Volkswagen', 'Amarok',	 'R$70.978'
go

select * from Cliente
go

create or alter  procedure spCadCliente

		(
		@Nome			varchar (100),
		@Estado			varchar (2),
		@Cidade			varchar (100),
		@Bairro			varchar (100),
		@Rua				varchar (100),
		@Numero		int
		)
	as
		begin
			insert into Cliente (Nome, Estado, Cidade, Bairro, Rua, Numero)
				values (@Nome, @Estado,  @Cidade, @Bairro, @Rua, @Numero)
		end
go


/*

pesquisar bairros mais populosos de cada capital
pesquisar a rua ou avenida da prefeitura e numero, mesmo que nao seja no mesmo bairro

*/
		-- São José do Rio Preto São Paulo SP
exec spCadCliente
	'Gabriel Oliveira', 'SP', 'São José do Rio Preto', 'Boa Vista', 'Silva Jardim', '1111'

		-- 	Rio Branco	Acre	 AC	
exec spCadCliente
	'Tomas Hanks', 'AC', 'Rio Branco', 'Bosque', 'Av. Epaminondas Jácome', '1383' 

		--Maceió	Alagoas	AL	
exec spCadCliente
	'Antonio Ramos', 'AL', 'Maceió', 'Benedito Bentes', 'R. Sá e Albuquerque', '235'

		--Macapá	Amapá	AP	
exec spCadCliente
	'Reginaldo Janekinny', 'AP', 'Macapá', 'Buritizal', 'Av. Fab', '840'

		--Manaus	 Amazonas	AM
exec spCadCliente
	'Richard Candy', 'AM', 'Manaus', 'Cidade Nova', 'R. Projetada 4', '4' 

		-- Salvador	Bahia	BA
exec spCadCliente
	'Giovana Antonella', 'BA', 'Salvador', 'Cajazeiras', 'R. Carlos Gomes', '270'

		-- Fortaleza	 Ceará	CE	
exec spCadCliente
	'Beth Fez', 'CE', 'Fortaleza', 'Mondubim', 'Rua São José', '01' 

		-- Brasília	Distrito Federal	DF	
exec spCadCliente
	'Tarcisio Pai', 'DF', 'Brasilia', 'Ceilandia', 'Zona Cívico-Administrativa', '00'

		-- Vitória	Espírito Santo	ES
exec spCadCliente
	'Tarcisio Junior', 'ES', 'Vitoria', 'Jardim Camburi', 'Av. Mal. Mascarenhas de Moraes', '1927'

		-- Goiânia	Goiás	GO	
exec spCadCliente
	'Paula Fernanda', 'GO', 'Goiânia', 'Jardim América', 'Av. do Cerrado', '999'

		-- São Luís	Maranhão	MA	
exec spCadCliente
	'Vera Fish', 'MA', 'São Luís', 'Cidade Operária', 'Av. Dom Pedro ll', '00'

		-- Cuiabá	Mato Grosso	MT	
exec spCadCliente
	'Giovanna Tidone', 'MT', 'Cuiabá', 'Altos do Coxipó', 'Praça Alencastro', '158'

		-- Campo Grande	Mato Grosso do Sul	 MS
exec spCadCliente
	'Sthephany Bryto', 'MS', 'Campo Grande', 'Aero Rancho', 'Av. Afonso Pena', '3297'

		-- Belo Horizonte	Minas Gerais	MG	
exec spCadCliente
	'Fatima Bernardo', 'MG', 'Belo Horizonte', 'Sagrada Família', 'Av. Afonso Pena', '1212' 

		-- Belém	Pará	PA	
exec spCadCliente
	'Joelma', 'PA', 'Belém', 'Curió-Utinga', 'Praça Dom Pedro II', '2'

		-- João Pessoa	 Paraíba	 PB
exec spCadCliente
	'Renato Aragorn', 'PB', 'Jõao Pessoa', 'Mangabeira', 'Praça Pedro Américo', '70' 

		-- Curitiba	Paraná	PR	
exec spCadCliente
	'Ximbinha', 'PR', 'Curitiba', 'Cidade Industrial', 'Av. Cândido de Abreu', '817' 

		-- Recife	Pernambuco	PE	
exec spCadCliente
	'William Bonder', 'PE', 'Recife', 'Guabiraba', 'Cais do Apolo', '925'

		-- Teresina	Piauí	PI	
exec spCadCliente
	'Visconde de Sabugosa', 'PI', 'Teresina', 'Itararé', 'Praça Marechal Deodoro', '860' 

		-- Rio de Janeiro	Rio de Janeiro	RJ	
exec spCadCliente
	'Bob Burnquist', 'RJ',	'Rio de Janeiro', 'Campo Grande', 'R. Visc. de Jequitinhonha', '50' 

		-- Natal	Rio Grande do Norte	RN	
exec spCadCliente
	'Hebert Viuana', 'RN', 'Natal', 'Felipe Camarão', 'R. Ulisses Caldas', '81' 

		-- Porto Alegre	Rio Grande do Sul	RS	
exec spCadCliente
	'Paula Tuller', 'RS', 'Porto Alegre', 'Cohab Rubem Berta', 'R. Gen. João Manoel', '157'

		-- Porto Velho	Rondônia	RO	
exec spCadCliente
	'Gloria Maria', 'RO', 'Porto Velho','Caiari', 'Av. Sete de Setembro', '237'

		-- Boa Vista	Roraima	RR	
exec spCadCliente
	'Sidney Moreira', 'RR', 'Boa Vista', 'Pintolândia', 'R. Gen. Penha Brasil', '1011'

		-- Florianópolis	Santa Catarina 	SC	
exec spCadCliente
	'Pedro Miau', 'SC', 'Florianopolis', 'Praia dos Ingleses', 'R. Conselheiro Mafra', '656' 

		-- Aracaju	Sergipe	SE	
exec spCadCliente
	'Debora Faladela', 'SE', 'Aracaju', 'Santos Dumont', 'R. Frei Luiz Canolo de Noronha', '42'

		-- Palmas	Tocantins	TO	
exec spCadCliente
	'Bento Hinoto', 'TO',	'Palmas', 'Aureny III', 'Av. Juscelino Kubitscheck', '28' 

go


	select * from INFORMATION_SCHEMA.COLUMNS
	go

	select * from Cliente
	go