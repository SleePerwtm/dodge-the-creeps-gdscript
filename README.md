本仓库用于存储我的第一个 Godot 2d 游戏。

游戏的需求等来自于 Godot 的官方教程中 [你的第一个 2d 游戏](https://docs.godotengine.org/zh-cn/4.x/getting_started/first_2d_game/index.html)。

使用 GDScript 编写，Godot 4.6.1 版本开发。

# 一些知识点

## &"string"

表示字符串是 Godot 内置的 `StringName` 类型。这种类型在 Godot 引擎内部被广泛用于标识符，比如节点路径、动画名称、信号名称、组名等。

使用 `&"string"` 的主要优势是 性能优化。

在需要频繁进行字符串比较或查找的场景下（例如，在 `_process()` 函数中每帧都检查动画状态），使用 `StringName` 可以避免重复创建 `String` 对象和进行耗时的字符串比较，从而带来轻微的性能提升。

当使用字符串来指代 Godot 引擎中的某个具体事物（如动画名、信号名、节点路径、属性名等）时，推荐使用 `&"name"`。这是 Godot 社区中越来越普遍的编码风格，因为它**语义更清晰**，且**性能更好**。
