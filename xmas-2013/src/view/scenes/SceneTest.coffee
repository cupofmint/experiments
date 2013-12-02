class SceneTest extends AbstractScene

	ctx 					: null
	index					: null
	reindeer 				: null


	constructor: (@ctx, @index) ->
		super

	update: ->
		super

		###
		for a in @reindeer.anchors
			a.update()
		###

	draw: ->
		hw = @ctx.width * .5
		hh = @ctx.height * .5
		scale = 1

		@ctx.strokeStyle = '#ccc'
		@ctx.lineWidth = 1
		@ctx.beginPath()

		for i in [0...@reindeer.anchors.length]
			a = @reindeer.anchors[i]
			if (!a.other) then continue
			# b = a.other
			# @ctx.moveTo(a.pos.x * scale + hw, a.pos.y * scale + hh)
			# @ctx.lineTo(b.pos.x * scale + hw, b.pos.y * scale + hh)

			# if (i % 2 || i < 1 || i > 120) then continue
			# if (i != 8 && i != 13) then continue
			# if (!a.right) then continue
			a = @reindeer.anchors[i]
			# b = @reindeer.anchors[i - 75]
			b = a.other
			@ctx.moveTo(a.pos.x * scale + hw, a.pos.y * scale + hh)
			@ctx.lineTo(a.pos.x * scale - a.length + hw, a.pos.y * scale + hh)
			@ctx.lineTo(a.pos.x * scale - a.length + hw, b.pos.y * scale + hh)
			@ctx.lineTo(b.pos.x * scale + hw, b.pos.y * scale + hh)

		###
		a = @reindeer.anchors[23]
		dy = a.pos.y * scale + hh - 200
		@ctx.moveTo(200, 200)
		@ctx.lineTo(350, 200)
		@ctx.lineTo(350 + dy, 200 + dy)
		@ctx.lineTo(a.pos.x * scale + hw, a.pos.y * scale + hh)
		###


		@ctx.stroke()
		@ctx.closePath()


		for a in @reindeer.anchors
			# if (a.index > 36 && a.index < 75 || a.index > 111) then continue
			# if (!a.right && !a.left && !a.leftFoot && !a.rightFoot) then continue
			if (!a.other) then continue
			@ctx.beginPath()
			@ctx.fillStyle = '#222'
			@ctx.strokeStyle = '#bbb'
			@ctx.lineWidth = 1
			@ctx.arc(a.pos.x * scale + hw, a.pos.y * scale + hh, a.radius, 0, TWO_PI)
			@ctx.fill()
			@ctx.stroke()
			@ctx.closePath()


		###
		for a in @reindeer.anchors
			@ctx.translate(hw, hh)
			a.draw()
			@ctx.setTransform(1, 0, 0, 1, 0, 0)
		###

		###
		if (app.view.ui.drawLines)
			@ctx.strokeStyle = '#fff'
			@ctx.fillStyle = '#E37C49'
			@ctx.beginPath()

			for i in [0...@reindeer.anchors.length]
				a = @reindeer.anchors[i]
				b = { pos:{} }
				b.pos.x = cos(a.angle) * 80 + a.pos.x
				b.pos.y = sin(a.angle) * 80 + a.pos.y

				@ctx.moveTo(a.pos.x * scale + hw, a.pos.y * scale + hh)
				@ctx.lineTo(b.pos.x * scale + hw, b.pos.y * scale + hh)

			b = @reindeer.anchors[0]
			# @ctx.lineTo(b.pos.x * scale + hw, b.pos.y * scale + hh)
			# @ctx.fill()
			@ctx.stroke()
			@ctx.closePath()
		###


		###
		if (app.view.ui.drawAnchors)
			for a in @reindeer.anchors
				@ctx.beginPath()
				# @ctx.strokeStyle = '#ffffff'
				@ctx.strokeStyle = a.color
				# @ctx.lineWidth = a.radius * .5
				@ctx.lineWidth = 2
				@ctx.arc(a.pos.x * scale + hw, a.pos.y * scale + hh, a.radius, 0, TWO_PI)
				# @ctx.fill()
				@ctx.stroke()
				@ctx.closePath()


		if (app.view.ui.drawLines)
			@ctx.lineCap = 'round'
			@ctx.lineJoin = 'round'

			scale = 1
			for i in [0...@reindeer.anchors.length - 1]
				a = @reindeer.anchors[i]
				b = @reindeer.anchors[i + 1]
				offset = 0
				if (a.left) then offset = -1000
				else if (a.right) then offset = 1000

				@ctx.beginPath()
				# @ctx.moveTo(a.pos.x * scale + hw, a.pos.y * scale + hh)
				# @ctx.lineTo(b.pos.x * scale + hw, b.pos.y * scale + hh)
				# @ctx.lineTo(a.pos.x + hw + offset, a.pos.y + hh)

				@ctx.moveTo(a.pos.x + cos(a.angle) * 150 + hw, a.pos.y + sin(a.angle) * 150 + hh)
				@ctx.lineTo(b.pos.x + cos(b.angle) * 150 + hw, b.pos.y + sin(b.angle) * 150 + hh)
				@ctx.strokeStyle = 'rgb(255, 255, 255)'
				@ctx.lineWidth = a.lineWidth
				@ctx.stroke()
				@ctx.closePath()

			# @ctx.lineTo(@reindeer.anchors[0].pos.x + hw, @reindeer.anchors[0].pos.y + hh)
		###


	initReindeer: ->
		super

		##

		leftArm = []
		rightArm = []
		leftLegLeft = []
		rightLegRight = []
		leftHip = []
		rightHip = []
		leftFoot = []
		rightFoot = []
		leftHead = []
		rightHead = []
		leftHornLeft = []
		rightHornRight = []

		for a in @reindeer.anchors
			if (a.leftArm) then leftArm.push(a)
			else if (a.rightArm) then rightArm.push(a)
			else if (a.leftLegLeft) then leftLegLeft.push(a)
			else if (a.rightLegRight) then rightLegRight.push(a)
			else if (a.leftHip) then leftHip.push(a)
			else if (a.rightHip) then rightHip.push(a)
			else if (a.leftFoot) then leftFoot.push(a)
			else if (a.rightFoot) then rightFoot.push(a)
			else if (a.leftHead) then leftHead.push(a)
			else if (a.rightHead) then rightHead.push(a)
			else if (a.leftHornLeft) then leftHornLeft.push(a)
			else if (a.rightHornRight) then rightHornRight.push(a)

			a.radius = 2
			# a.length = random(50, 550)
			if (a.right) then a.length = random(20, 60)
			else a.length = random(-30, -60)
			# if (a.rightHorn || a.leftHorn) then a.length *= 0.25


		for a in leftArm
			index = floor(random(rightArm.length))
			a.other = rightArm[index]
			rightArm.splice(index, 1)
			if (!a.other)
				index = floor(random(leftArm.length))
				a.other = leftArm[index]

		for a in leftHip
			index = floor(random(rightHip.length))
			a.other = rightHip[index]
			rightHip.splice(index, 1)
			if (!a.other)
				index = floor(random(leftHip.length))
				a.other = leftHip[index]

		for a in rightHead
			index = floor(random(leftHead.length))
			a.other = leftHead[index]

		for a in leftHead
			index = floor(random(rightHead.length))
			a.other = rightHead[index]
			rightHead.splice(index, 1)
			if (!a.other)
				index = floor(random(leftHead.length))
				a.other = leftHead[index]

		for a in leftLegLeft
			if (!a) then continue
			index = floor(random(rightLegRight.length))
			a.other = rightLegRight[index]
			rightLegRight.splice(index, 1)

		###
		for a in rightLeg
			if (!a) then continue
			index = floor(random(rightLeg.length))
			a.other = rightLeg[index]
			rightLeg.splice(index, 1)
		###

		for a in leftFoot
			if (!a) then continue
			index = floor(random(leftFoot.length))
			a.other = leftFoot[index]
			leftFoot.splice(index, 1)

		for a in rightFoot
			if (!a) then continue
			index = floor(random(rightFoot.length))
			a.other = rightFoot[index]
			rightFoot.splice(index, 1)

		for a in leftHornLeft
			if (!a) then continue
			index = floor(random(rightHornRight.length))
			a.other = rightHornRight[index]
			rightHornRight.splice(index, 1)

		###
		for a in rightHorn
			if (!a) then continue
			index = floor(random(rightHorn.length))
			a.other = rightHorn[index]
			rightHorn.splice(index, 1)
		###
		##


		###
		@reindeer.initRibbonAnchors()

		# set extra properties
		length = @reindeer.anchors.length
		for i in [0...length]
			a = @reindeer.anchors[i]
			
			if (i > 0) then p = @reindeer.anchors[i - 1].positions[0]
			else p = a.positions[0]
			if (i < length - 1) then n = @reindeer.anchors[i + 1].positions[0]
			else n = a.positions[0]

			dx = p.x - n.x
			dy = p.y - n.y
			# dd = Math.sqrt(dx * dx + dy * dy)
			a.angle = Math.atan2(dy, dx) + HALF_PI

			# a.color = 'rgb(20, ' + floor(random(50, 255)) + ', ' + floor(random(10, 50)) + ')'
			# a.color = 'rgb(' + floor(random(150, 255)) + ', ' + floor(random(150, 255)) + ', 25)'
			# a.color = 'rgb(' + floor(random(140, 200)) + ', ' + floor(random(50, 100)) + ', ' + floor(random(20, 50))+ ')'
			# a.color = '#000'
			a.color = 'rgb(' + floor(random(20, 50)) + ', ' + (220 - floor((a.pos.y + 300) / 570 * 150)) + ', ' + floor(random(10, 50)) + ')'
			a.radius = 4
			a.ctx = @ctx
			# a.LENGTH = 10 - (a.pos.y + 300) / 540 * 10
			a.LENGTH = 8
		###