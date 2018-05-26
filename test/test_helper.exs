ExUnit.start()

Mox.defmock(Mock.DatesGiver, for: Domain.IGiveDates)
Mox.defmock(Mock.PrsReader, for: Domain.IReadPrs)
