larguratela = love.graphics.getWidth()
alturatela = love.graphics.getHeight()
ultimaspontuacoes={}
velocidade=(100/1.05)
altlinha=505

--[[
	Tarefa 07
	Sobre a array 'obstaculos':
	Escopo: Como no 'default' de toda variável em lua, a array 'obstáculos' é uma variável global, ou seja, pode ser vista em todo o programa.
	
	Tempo de Vida: O tempo de vida da array é durante toda a execução do jogo.
	
	Alocação: A array é alocada quando é executada a função 'love.load()'.
	
	Desalocação: A desalocação acontece quando o jogo é encerrado (fechar na janela, ou, ao perder, apertando a tecla 'S').
	
	Observação: A cada começo de partida, a array 'obstaculos' é 'resetada', já havendo um elemento na posição 0, que servirá de referência para criação dos outros obstáculos, ao longo do jogo.
--]]

function love.load(  )
	player={ x=50,  y=400, larg=75, alt=100,chao=400,velpulo=0,altpulo=-200,gravidade=-100}
	adicionouultima=false
	pontuacao=0	
	love.graphics.setFont(love.graphics.newFont(30))
	perdeu=false
	comecou=false
	obstaculos={}
	--[[
		Tarefa 07
		Sobre um objeto da array 'obstaculos':
		
		Escopo: Como a array já é global por si só, todo elemento contido também será global, por consequência.
		
		Tempo de Vida: seu tempo de vida será desde o momento em que ele é criado (quando o jogador faz um pulo) até o momento em que ele passa do jogador (considera-se que o jogador passou por aquele obstáculo).
		
		Alocação: ele será criado, e posteriormente alocado na array, quando o player faz um pulo. Todos os obstáculos vão contra o jogador 'ao mesmo tempo'.
		
		Desalocação: será desalocado quando estiver passado do jogador, ou seja, quando sua localização for menor que a localização do jogador, que nesta hora é considerado que o player já passou por este obstáculo, e com isso ele é desalocado.
	--]]
end

function love.keypressed( key )
	if not perdeu then
		if key == 'up' then
			comecou=true
			if player.velpulo == 0 then
				local randalt=math.random(100,150)
				local alty=altlinha-5-randalt
				local obstaculo={x=larguratela,y=alty, larg=100, alt=randalt}
				table.insert(obstaculos,obstaculo) --Aqui é criado um novo obstáculo, que é o que será 'jogado no jogo' (será sempre uma cópia do obstáculo dito anteriormente (comando acima) ).
				player.velpulo = player.altpulo
			end
		elseif key == 'down' then
			if player.velpulo ~= 0 then
				player.y=player.chao
				player.velpulo=0
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
			local desc=velocidade*dt
			deslocarobstaculos(desc)
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
	for index,v in pairs(obstaculos) do
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.rectangle('fill',v.x, v.y, v.larg, v.alt)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle('line',v.x, v.y, v.larg, v.alt)
		love.graphics.setColor(0,0,0, 255)
		love.graphics.print("X",v.x+30,v.y+15,0,2,2,0,0,0,0)
		love.graphics.setColor(255, 255, 255, 255)
	end
end

function desenharlinha()
	love.graphics.setLineWidth(10)
	love.graphics.line(0,altlinha,larguratela,altlinha)
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
	for i=#obstaculos,1,-1 do
		if(obstaculos[i].x<-100) then
			table.remove(obstaculos,i) --Nesta hora é desalocado um obstáculo, pois é visto que o obstáculo já passou pelo player, e o player passou por cima do obstáculo.
			velocidade=velocidade*1.05
		end
	end
end

function colidiu()
	for index,v in pairs(obstaculos) do
		perdeu = perdeu or (player.x+player.larg >= v.x) and 
						  (player.x <= v.x+v.larg) and
						  (player.y+player.alt >= v.y) and 
						  (player.y <= v.y+v.alt)
	end
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

function deslocarobstaculos(desc)
	for index,v in pairs(obstaculos) do
		v.x=v.x-desc
	end
end
