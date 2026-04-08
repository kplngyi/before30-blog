---
title: "梯度下降与反向传播"
description: "知识"
pubDate: 2026-04-08
tags: ["工作"]
---
# 梯度下降与反向传播（从直觉到公式）

## 一、核心概念

在神经网络训练中，参数优化依赖两个关键过程：

- **反向传播（Backpropagation）**：计算梯度
- **梯度下降（Gradient Descent）**：更新参数

👉 核心关系：

$$
\text{参数更新} = \text{参数} - \eta \cdot \nabla L
$$

其中：
- $\eta$：学习率（learning rate）
- $\nabla L$：损失函数对参数的梯度

---

## 二、梯度的本质

> 梯度 = 损失函数对参数的导数

它表示：

👉 **当参数变化一点时，Loss 会如何变化**

---

### 一个简单例子

$$
y = w \cdot x
$$

$$
L = (y - y_{true})^2
$$

---

### 梯度计算（链式法则）

$$
\frac{\partial L}{\partial w}
= \frac{\partial L}{\partial y} \cdot \frac{\partial y}{\partial w}
$$

分别计算：

$$
\frac{\partial L}{\partial y} = 2(y - y_{true})
$$

$$
\frac{\partial y}{\partial w} = x
$$

👉 合并：

$$
\frac{\partial L}{\partial w} = 2(y - y_{true}) \cdot x
$$

---

## 三、梯度的直觉理解

> 梯度 = 误差 × 输入

- 误差越大 → 更新越大  
- 输入越大 → 对参数影响越大  

---

## 四、为什么是“减去梯度”

梯度表示的是：

> 👉 Loss 增长最快的方向

而我们希望：

> 👉 最小化 Loss

所以需要：

$$
\text{往反方向走}
$$

即：

$$
W \leftarrow W - \eta \cdot \nabla_W L
$$

---

### 直观理解（下山问题）

- 梯度：指向“上坡最快”
- 更新：往“下坡方向”走

---

## 五、参数更新过程

以单参数为例：

$$
w \leftarrow w - \eta \cdot \frac{\partial L}{\partial w}
$$

例如：

- 梯度 = -32  
- 学习率 = 0.1  

$$
w = w - 0.1 \cdot (-32) = w + 3.2
$$

👉 参数变大（因为预测偏小）

---

## 六、反向传播的作用

反向传播用于：

> 👉 **计算每一层参数的梯度**

---

### 过程

假设网络：

$$
x \rightarrow W_1 \rightarrow h \rightarrow W_2 \rightarrow y \rightarrow L
$$

反向传播：

$$
L \rightarrow y \rightarrow W_2 \rightarrow h \rightarrow W_1
$$

---

### 核心公式（链式法则）

$$
\frac{\partial L}{\partial W_1}
= \frac{\partial L}{\partial h} \cdot \frac{\partial h}{\partial W_1}
$$

---

## 七、在 Transformer 中的体现

以 Attention 为例：

$$
Q = W_q x
$$

梯度：

$$
\frac{\partial L}{\partial W_q}
= \frac{\partial L}{\partial Q} \cdot x
$$

👉 本质：

> 梯度 = 上游误差 × 当前输入

---

## 八、完整训练流程

$$
\text{输入} \rightarrow \text{预测} \rightarrow \text{计算 Loss}
\rightarrow \text{反向传播} \rightarrow \text{更新参数}
$$

不断重复：

👉 模型逐步逼近最优解

---

## 九、工程中的优化方法

实际中不会直接用原始梯度下降，而是使用：

- SGD（随机梯度下降）
- Adam（最常用）

Adam 本质：

$$
W \leftarrow W - \eta \cdot \text{平滑后的梯度}
$$

---

## 十、训练 vs 推理

| 阶段 | 是否计算梯度 | 是否更新参数 |
|------|--------------|--------------|
| 训练 | ✅ | ✅ |
| 推理 | ❌ | ❌ |

---

## 十一、关键理解总结

### 1️⃣ 梯度
👉 告诉你“怎么改参数”

---

### 2️⃣ 反向传播
👉 告诉每一层“你错了多少”

---

### 3️⃣ 梯度下降
👉 实际执行“参数修正”

---

## 十二、一句话总结

> 梯度告诉你“哪里更糟”，反向传播负责计算梯度，梯度下降负责沿着反方向更新参数，从而逐步降低损失函数。