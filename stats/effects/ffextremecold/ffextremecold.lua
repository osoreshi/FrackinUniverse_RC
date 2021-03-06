function init()
  animator.setParticleEmitterOffsetRegion("icetrail", mcontroller.boundBox())
  animator.setParticleEmitterActive("icetrail", true)
  effect.setParentDirectives("fade=00BBFF=0.15")

  script.setUpdateDelta(5)

  local slows = status.statusProperty("slows", {})
  slows["frostslow"] = 0.75
  status.setStatusProperty("slows", slows)
  self.tickDamagePercentage = 0.005
  self.tickTime = 1.0
  self.tickTimer = self.tickTime
end

function update(dt)
  mcontroller.controlModifiers({
      groundMovementModifier = -0.7,
      runModifier = -0.55,
      jumpModifier = -0.55
    })

  self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = self.tickTime
    status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) + 0.5,
        damageSourceKind = "nitrogenweapon",
        sourceEntityId = entity.id()
      })
  end
  
end

function uninit()
  local slows = status.statusProperty("slows", {})
  slows["frostslow"] = nil
  status.setStatusProperty("slows", slows)
end