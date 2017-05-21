larguratela = love.graphics.getWidth()
alturatela = love.graphics.getHeight()

function love.load(  )
	player={ x=50,  y=400, larg=75, alt=100,chao=400,velpulo=0,altpulo=-200,gravidade=-100}
	obstaculo={ x=larguratela,  y=400, larg=100, alt=100,vel=100}
	pontuacao=0	
	love.graphics.setFont(love.graphics.newFont(30))
	perdeu=false
end

function love.keypressed( key )
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
		local desc=obstaculo.vel*dt
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
