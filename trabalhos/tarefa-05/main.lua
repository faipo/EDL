larguratela = love.graphics.getWidth()
alturatela = love.graphics.getHeight()

function love.load(  )
	player={ x=50,  y=400, larg=75, alt=100,chao=400,velpulo=0,altpulo=-200,gravidade=-100}
	--[[
		Nome: 		variável "player"
		Propriedade:	tipo
		Binding time:	compilação
		Explicação:	como será uma variável que será usada em todo o programa,
		mesmo tendo seu escopo dentro do love.load(), ela terá seu tipo definido em tempo
		de compilação, neste caso, uma tabela.
	--]]
	obstaculo={ x=larguratela,  y=400, larg=100, alt=100,vel=100}
	pontuacao=0
	--[[
	Nome: 		variável "pontuacao"
	Propriedade: 	endereço
	Binding time:	execução
	Explicação:	somente na hora em que for carregado o jogo é que
	será feita a amarração entre um endereço de memória e a variável
	"pontuacao", logo, seu endereço só será sabido em tempo de execução.
	--]]	
	love.graphics.setFont(love.graphics.newFont(30))
	perdeu=false
end
--[[ 
 Nome: 		palavra reservada "false"
 Propriedade: 		semântica (significado)
 Binding time: 		design da linguagem
 Explicação: 		dado que "false" é uma palavra
 reservada da linguagem Lua, logo, no tempo de design da linguagem
 foi definido (amarrado) o que significaria ela.
 --]]

function love.keypressed( key )
	--[[
	Nome:		variável "key"
	Propriedade:	conteúdo
	Binding time:	execução
	Explicação:	"key" é o parâmetro da função "love.keypressed".
	"key" só saberá qual foi a tecla pressionada, ou seja, qual será seu valor
	em tempo de execução.
	--]]
	if key == 'up' then
		if player.velpulo == 0 then
			player.velpulo = player.altpulo
		end
	elseif key=='s' then
		love.event.quit()
	elseif key=='r' then
		love.load()
	end
end

function love.update( dt )
	colidiu()
	if not perdeu then
		desc=obstaculo.vel*dt
		obstaculo.x=obstaculo.x-desc
		pontuacao=pontuacao+(desc*0.1)
		testaralturapulo(dt)
	 	testarplayernochao()
	 	obstaculopassou()
	 end
end

function love.draw(  )
	love.graphics.print(string.format("Pontuação: %.2f",pontuacao),800,30)
	desenharelementos()
	if perdeu then
		fimdejogo()
	end
	--[[
		Nome: sintaxe "if then"
		Propriedade: sintaxe
		Binding time: design da linguagem
		Explicação: a definição de como seria implementado a sintaxe do 
		"if then" é feita quando a linguagem está sendo criada, ou seja,
		toda a parte da semântica das palavras reservadas e as implementações
		de operações simples da linguagem (implementação dos símbolos da linguagem)
		é amarrada em tempo de design da linguagem.

	--]]
end

-- funções criadas
function desenharelementos()
	desenharplayer()
	desenharlinha()
	desenharobstaculo()
end

function desenharobstaculo()
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.rectangle('fill', obstaculo.x,obstaculo.y, obstaculo.larg,obstaculo.alt)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle('line', obstaculo.x,obstaculo.y, obstaculo.larg,obstaculo.alt)
	love.graphics.setColor(0,0,0, 255)
	love.graphics.print("X",obstaculo.x+30,obstaculo.y+15,0,2,2,0,0,0,0)
	love.graphics.setColor(255, 255, 255, 255)
end
--[[
	Nome: função "desenharobstaculo"
	Propriedade: implementação
	Binding time: compilação
	Explicação: com a compilação deste jogo, todos os métodos já terão sua implementação "traduzida", e além disso, toda a biblioteca "löve" será "importada",
	com isso todos os métodos terão sua implementação amarrada em tempo de compilação.
--]]

function desenharlinha()
	love.graphics.setLineWidth(10)
	love.graphics.line(0,505,larguratela,505)
	love.graphics.setLineWidth(1)
end

function desenharplayer()
	love.graphics.setColor(35,142,35, 255)
	love.graphics.rectangle('fill', player.x,player.y,player.larg,player.alt)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle('line',player.x,player.y,player.larg,player.alt)
end

function testaralturapulo(dt)
	if player.velpulo ~= 0 then 
		player.y = player.y + player.velpulo * dt
		player.velpulo = player.velpulo - player.gravidade * dt
	end
end

function testarplayernochao()
	if player.y > player.chao then
		player.velpulo = 0
		player.y = player.chao
	end
end

function obstaculopassou()
	if obstaculo.x<-100 then
		obstaculo.x=larguratela
		obstaculo.vel=obstaculo.vel*1.05
	end
end

function colidiu()
	perdeu = (player.x+player.larg >= obstaculo.x) and 
		  (player.x <= obstaculo.x+obstaculo.larg) and
		  (player.y+player.alt >= obstaculo.y) and 
		  (player.y <= obstaculo.y+obstaculo.alt)
end

function fimdejogo()
	love.graphics.rectangle('fill', 20,20,larguratela-40,alturatela-40)
	love.graphics.printf({{0,0,0},"Fim de jogo!"},0,100,634,"center",0,2,2,0,0,0,0)
	love.graphics.printf({{0,0,0},string.format("Pontuação feita: %.2f pontos",pontuacao)},0,250,750,"center",0,1.75,1.75,0,0,0,0)
	love.graphics.printf({{0,0,0},"Aperte S para sair ou R para recomeçar o jogo."},0,400,850,"center",0,1.5,1.5,0,0,0,0)

end