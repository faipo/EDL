larguratela = love.graphics.getWidth()
alturatela = love.graphics.getHeight()
ultimaspontuacoes={}

--[[
	Tarefa 07
	Sobre a array 'obstaculos':
	Escopo: Como no 'default' de toda variável em lua, a array 'obstáculos' é uma variável global, ou seja, pode ser vista em todo o programa.
	Tempo de Vida: O tempo de vida da array é durante toda a execução do jogo.
	Alocação: A array é alocada quando é executada a função 'love.load()'.
	Desalocação: A desalocação acontece quando o jogo é encerrado (fechar na janela, ou, ao perder, apertando a tecla 'S').

	Observação: A cada começo de partida, a array 'obstaculo' é 'resetada', já havendo um elemento na posição 0, que servirá de referência para criação dos outros obstáculos, ao longo do jogo.
--]]

function love.load(  )
	player={ x=50,  y=400, larg=75, alt=100,chao=400,velpulo=0,altpulo=-200,gravidade=-100}
	adicionouultima=false
	pontuacao=0	
	love.graphics.setFont(love.graphics.newFont(30))
	perdeu=false
	comecou=false
	obstaculos={[0]={ x=larguratela,  y=400, larg=100, alt=100,vel=(100/1.05)}}
	--[[
		Tarefa 07

		Sobre um objeto da array 'obstaculos':

		Legenda: 
		(1): caso em que se refere ao objeto da posição 0 da array.
		(2): caso em que se refere a um objeto diferente da posição 0.


		Escopo: Como a array já é global por si só, todo elemento contido também será global, por consequência.
		Tempo de Vida: 
			Para o caso (1): ele acabará tendo como tempo de vida o jogo todo.
			Para o caso (2): seu tempo de vida será desde o momento em que ele é criado (quando o jogador faz um pulo) até o momento em que ele passa do jogador (considera-se que o jogador passou por aquele obstáculo).
		Alocação:
			Para o caso (1): ele será alocado no momento em que é invocado o método 'love.load()'.
			Para o caso (2): ele será criado, e posteriormente alocado na array, quando o player faz um pulo. Está array seria uma espécie de 'obstáculos que já estão prontos para ir ao jogador'.
		Desalocação:
			Para o caso (1): será desalocado quando o jogo encerrar, ser fechado.
			Para o caso (2): será desalocado quando estiver passado do jogador, ou seja, quando sua localização for menor que a localização do jogador, que nesta hora é considerado que o player já passou por este obstáculo, e com isso ele é desalocado.
	--]]
end

function love.keypressed( key )
	if not perdeu then
		if key == 'up' then
			comecou=true
			if player.velpulo == 0 then
				table.insert(obstaculos,{ x=larguratela,  y=400, larg=100, alt=100,vel=(obstaculos[#obstaculos].vel*1.05)}) --Aqui é criado um novo obstáculo, que é o que será 'jogado no jogo' (o que está no índice 0 serve apenas como referência de criação para os outros).
				player.velpulo = player.altpulo
			end
		end
	else
		if key=='s' then
			love.event.quit()
		elseif key=='r' then
			love.load()
		end
	end
end

function love.update( dt )
	if comecou then
		colidiu()
		if not perdeu then
			desc=obstaculos[1].vel*dt
			obstaculos[1].x=obstaculos[1].x-desc
			pontuacao=pontuacao+(desc*0.1)
			testaralturapulo(dt)
		 	testarplayernochao()
		 	obstaculopassou()
		 end
	end
end

function love.draw(  )
	if comecou then
		love.graphics.print(string.format("Pontuação: %.2f",pontuacao),800,30)
		desenharelementos()
		if perdeu then
			fimdejogo()
		end
	else
		love.graphics.printf({{255,255,255},"Pule para começar"},0,alturatela/2,larguratela/2,"center",0,1.5,1.5,0,0,0,0)
	end
end

-- funções criadas
function desenharelementos()
	desenharplayer()
	desenharlinha()
	desenharobstaculo()
end

function desenharobstaculo()
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.rectangle('fill', obstaculos[1].x,obstaculos[1].y, obstaculos[1].larg,obstaculos[1].alt)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle('line', obstaculos[1].x,obstaculos[1].y, obstaculos[1].larg,obstaculos[1].alt)
	love.graphics.setColor(0,0,0, 255)
	love.graphics.print("X",obstaculos[1].x+30,obstaculos[1].y+15,0,2,2,0,0,0,0)
	love.graphics.setColor(255, 255, 255, 255)
end

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
	if obstaculos[1].x<-100 then
		table.remove(obstaculos,1) --Nesta hora é desalocado um obstáculo, pois é visto que o obstáculo já passou pelo player, e o player passou por cima do obstáculo.
	end
end

function colidiu()
	perdeu = (player.x+player.larg >= obstaculos[1].x) and 
		  (player.x <= obstaculos[1].x+obstaculos[1].larg) and
		  (player.y+player.alt >= obstaculos[1].y) and 
		  (player.y <= obstaculos[1].y+obstaculos[1].alt) 
		  --[[Nesta hora é testado se o obstáculo colidiu com o jogador, fazendo com que a partida seja terminada, informando pontuação do jogo, pontuação média, e dando as opções de recomeçar ou de sair do jogo. Observação: o obstáculo testado é aquele que está se movendo na tela (no caso o de índice 1 da array).
		  --]]
end

function fimdejogo()
	love.graphics.rectangle('fill', 20,20,larguratela-40,alturatela-40)
	love.graphics.printf({{0,0,0},"Fim de jogo!"},0,100,634,"center",0,2,2,0,0,0,0)
	love.graphics.printf({{0,0,0},string.format("Pontuação feita: %.2f pontos",pontuacao)},0,250,750,"center",0,1.75,1.75,0,0,0,0)
	love.graphics.printf({{0,0,0},"Aperte S para sair ou R para recomeçar o jogo."},0,400,850,"center",0,1.5,1.5,0,0,0,0)
	historicopont()
	love.graphics.printf({{0,0,0},string.format("Pontuação média: %.2f",pontuacaomedia())},0,600,850,"center",0,1.5,1.5,0,0,0,0)
end

function historicopont()
	if not adicionouultima then
		ultimaspontuacoes[#ultimaspontuacoes+1]=pontuacao
	end
	adicionouultima=true
end

function pontuacaomedia()
	sum=0
	for i=1,#ultimaspontuacoes do
		sum=sum+ultimaspontuacoes[i]
	end
	return sum/#ultimaspontuacoes
end
