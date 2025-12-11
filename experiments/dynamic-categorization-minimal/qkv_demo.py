import numpy as np

def softmax(x):
    """数值稳定的softmax"""
    exp_x = np.exp(x - np.max(x, axis=-1, keepdims=True))
    return exp_x / np.sum(exp_x, axis=-1, keepdims=True)

class DynamicCategorizer:
    """
    最小动态分类器：演示QKV如何实现上下文敏感的类别响应
    """
    def __init__(self, d_model=64):
        self.d_model = d_model
        # 模拟预训练得到的响应语义库（实际中由W_V参数化）
        self.response_templates = {
            "positive": np.random.randn(d_model) * 0.5 + 1,
            "negative": np.random.randn(d_model) * 0.5 - 1,
            "neutral": np.zeros(d_model)
        }
        
    def embed_token(self, token):
        """简单确定性嵌入（相同token返回相同向量）"""
        np.random.seed(hash(token) % (2**32))
        return np.random.randn(self.d_model)
    
    def get_response_vector(self, token):
        """根据token语义返回预存响应向量"""
        if "好" in token or "优" in token:
            return self.response_templates["positive"]
        elif "坏" in token or "差" in token:
            return self.response_templates["negative"]
        else:
            return self.response_templates["neutral"]
    
    def forward(self, context, query):
        """
        动态分类核心流程
        :param context: 上下文token列表，如 ["这个", "电影", "很", "好"]
        :param query: 查询token，如 "评价"
        :return: 响应向量及注意力权重
        """
        # 1. 嵌入所有token
        context_embs = np.array([self.embed_token(t) for t in context])
        query_emb = self.embed_token(query)
        
        # 2. 投影到Q, K, V空间（随机初始化模拟训练后权重）
        Wq = np.random.randn(self.d_model, self.d_model)
        Wk = np.random.randn(self.d_model, self.d_model)
        # V使用语义响应向量而非嵌入
        V = np.array([self.get_response_vector(t) for t in context])
        
        Q = query_emb @ Wq
        K = context_embs @ Wk
        
        # 3. 计算注意力
        scores = Q @ K.T / np.sqrt(self.d_model)
        weights = softmax(scores)
        
        # 4. 加权聚合响应
        output = weights @ V
        
        return output, weights

# 示例运行
if __name__ == "__main__":
    model = DynamicCategorizer()
    
    # 测试1：正面上下文
    context1 = ["这个", "产品", "非常", "好"]
    output1, weights1 = model.forward(context1, "总结")
    print("正面上下文注意力权重:", weights1)
    print("响应向量均值:", np.mean(output1))
    
    # 测试2：负面上下文
    context2 = ["服务", "太", "差", "了"]
    output2, weights2 = model.forward(context2, "总结")
    print("\n负面上下文注意力权重:", weights2)
    print("响应向量均值:", np.mean(output2))