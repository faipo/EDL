larguratela = love.graphics.getWidth()
alturatela = love.graphics.getHeight()
ultimaspontuacoes={}
velocidade=(100/1.05)
altlinha=505
posicoesnuvens={ {30,50},{415,50},{800,50}}
nuvens={love.graphics.newImage("nuvem.png"),love.graphics.newImage("nuvem.png"),love.graphics.newImage("nuvem.png"),["desc"]=20,["descmax"]=75}
love.graphics.setBackgroundColor(51,113,160)

-- trabalho-08 - Closure do jogador
function novojogador (x,y,larg,alt,chao,velpulo,altpulo,gravidade)
  return {
    nochao=function()
    	return velpulo==0
    end,
    pular=function ()
    	velpulo=altpulo
    end,
    voltaraochao=function()
    	y=chao
    	velpulo=0
    end,
    getdadosdoplayer=function()
    	return x,y,larg,alt
    end,
    testaralturapulo=function(dt)
   	if velpulo ~= 0 then 
		y = y + velpulo * dt
		velpulo = velpulo - gravidade * dt
	end
     end,
     testarplayernochao=function ()
     	if y > chao then
		velpulo = 0
		y = chao
	end
     end
  }
end

function love.load(  ) 
	nuvens["valpordesc"]=nuvens.desc/nuvens.descmax
	mover=coroutine.create(movernuvem)
	player=novojogador(50,400,75,100,400,0,-200,-100)
	adicionouultima=false
	pontuacao=0	
	love.graphics.setFont(love.graphics.newFont(30))
	perdeu=false
	comecou=false
	obstaculos={}
	contmover=0
end

function love.keypressed( key )
	if not perdeu then
		if key == 'up' then
			comecou=true
			if player.nochao() then
				local randalt=math.random(100,135)
				local alty=altlinha-5-randalt
				local obstaculo={x=larguratela,y=alty, larg=100, alt=randalt}
				table.insert(obstaculos,obstaculo)
				player.pular()
			end
		elseif key == 'down' then
			if not player.nochao() then
				player.voltaraochao()
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
			player.testaralturapulo(dt)
		 	player.testarplayernochao()
		 	obstaculopassou()
		 end
	end
end

function love.draw(  )
	if comecou then
		desenharnuvens()
		coroutine.resume(mover)
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
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle('fill',0,altlinha-5,larguratela,altlinha)
end

function desenharplayer()
	local x,y,larg,alt=player.getdadosdoplayer()
	love.graphics.setColor(35,142,35, 255)
	love.graphics.rectangle('fill', x,y,larg,alt)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle('line',x,y,larg,alt)
end

function obstaculopassou()
	for index,v in pairs(obstaculos) do
		if(v.x<-100) then
			table.remove(obstaculos,index)
			velocidade=velocidade*1.05
		end
	end
end

function colidiu()
	local x,y,larg,alt=player.getdadosdoplayer()
	for index,v in pairs(obstaculos) do
		perdeu = perdeu or (x+larg >= v.x) and 
						  (x <= v.x+v.larg) and
						  (y+alt >= v.y) and 
						  (y <= v.y+v.alt)
	end
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

function desenharnuvens()
	love.graphics.draw(nuvens[1], posicoesnuvens[1][1],posicoesnuvens[1][2],0,0.8,0.5,0,0,0,0)
	love.graphics.draw(nuvens[2], posicoesnuvens[2][1],posicoesnuvens[2][2],0,0.8,0.5,0,0,0,0)
	love.graphics.draw(nuvens[3], posicoesnuvens[3][1],posicoesnuvens[3][2],0,0.8,0.5,0,0,0,0)
end

-- trabalho-08 - Corrotina para movimentar nuvens retangularmente
function movernuvem()
	while true do
		for i=1,nuvens["descmax"] do
			deslocarnuvens(0,nuvens.valpordesc)
			coroutine.yield()
		end
		for i=1,nuvens["descmax"] do
			deslocarnuvens(nuvens.valpordesc,0)
			coroutine.yield()
		end
		for i=1,nuvens["descmax"] do
			deslocarnuvens(0,-nuvens.valpordesc)
			coroutine.yield()
		end
		for i=1,nuvens["descmax"] do
			deslocarnuvens(-nuvens.valpordesc,0)
			coroutine.yield()
		end
	end
end

function deslocarnuvens(dx,dy)
	for k,v in pairs(posicoesnuvens) do
		v[1]=v[1]+dx
		v[2]=v[2]+dy
	end
end