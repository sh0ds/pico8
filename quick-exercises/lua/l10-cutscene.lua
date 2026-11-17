function cutscene()
    for i = 1,3 do
        print("door creaks")
        coroutine.yield()
    end
    for i = 1,2 do
        print("door opens")
        coroutine.yield()
    end
    print("done")
end

co = coroutine.create(cutscene)

for i = 1,8 do
    print("frame :"..i)
    coroutine.resume(co)
end

print(coroutine.status(co))
