11.3k star,这款开源软件真行啊

Surya 是一个文档 OCR 工具包，它支持90+ 种语言的 OCR任何语言都可以逐行文本检测。

![github.com/VikParuchuri/surya](image.png)


### Surya：全面的OCR工具包

**简介**

Surya 是一个开源的文档OCR（光学字符识别）工具包，旨在处理各种文档处理任务。由 Vik Paruchuri 开发，Surya 支持超过90种语言的OCR，使其成为全球应用的多功能工具。该工具包在文档分析的各个方面表现出色，包括布局检测、阅读顺序确定和表格识别。Surya 的性能与许多基于云的OCR服务相媲美，提供了一个强大且具有成本效益的替代方案，适用于个人和商业用途。

**主要特点**

1. **多语言OCR**：Surya 支持超过90种语言的OCR，确保其在不同地区和语言中的广泛适用性。这个功能对跨国组织和处理多样化数据集的研究人员特别有用。

2. **行级文本检测**：该工具包可以在任何语言中检测行级文本，提供精确和准确的文本提取。这一功能对于处理具有复杂布局和混合内容的文档至关重要。

3. **布局分析**：Surya 能够分析文档布局，识别表格、图像、标题等结构元素。这一功能增强了工具包处理各种文档类型的能力，从科学论文到扫描表格。

4. **阅读顺序检测**：该工具包可以确定文本的阅读顺序，这对于准确重建具有非线性文本流的文档内容（如报纸和杂志）非常重要。

5. **表格识别**：Surya 包含先进的表格识别功能，能够检测表格中的行和列。这一功能对于从文档中提取结构化数据特别有用。

**用户吸引力**

Surya 的特点使其成为寻求强大且灵活的OCR解决方案的用户的理想选择。以下是一些吸引用户的方面：

- **高精度**：Surya 的OCR精度可与领先的云服务相媲美，确保即使是噪声或低质量的文档也能可靠地提取文本。
- **开源**：作为开源软件，Surya 允许用户根据其特定需求自定义和扩展其功能。这种灵活性对开发人员和希望将OCR功能集成到其工作流程中的组织来说是一个显著优势。
- **成本效益**：Surya 为商业OCR服务提供了一个具有成本效益的替代方案，特别是对于需要处理大量文档的用户。该工具包的性能和可靠性使其成为小型企业和大型企业的宝贵资产。
- **社区支持**：Surya 拥有一个活跃的用户和开发者社区，他们为其持续开发和改进做出贡献。这种社区支持确保用户在需要时可以找到帮助和资源。

**快速入门指南**

开始使用 Surya 非常简单。以下是快速设置和使用该工具包的步骤：

1. **安装**：确保您的系统上安装了 Python 3.9+ 和 PyTorch。您可以使用 pip 安装 Surya：
   ```bash
   pip install surya-ocr
   ```
   模型权重将在您首次运行 Surya 时自动下载。

2. **配置**：检查 `surya/settings.py` 中的设置。您可以使用环境变量覆盖任何设置。例如，要指定 PyTorch 的设备，可以设置：
   ```bash
   export TORCH_DEVICE=cuda
   ```

3. **运行OCR**：使用提供的脚本对文档运行OCR。例如，要检测图像中的文本，可以使用：
   ```bash
   python detect_text.py --image_path path/to/your/image.jpg
   ```

4. **布局分析和表格识别**：Surya 包含用于布局分析和表格识别的脚本。您可以类似于文本检测脚本运行这些脚本，并为您的文档指定适当的参数。

通过这些步骤，您可以快速利用 Surya 强大的OCR功能来满足您的文档处理需求。

**结论**

Surya 作为一个全面且多功能的OCR工具包，具有高精度、多语言支持和先进的文档分析功能。其开源性质和活跃的社区使其成为开发人员和组织集成OCR到其工作流程中的理想选择。无论您是在处理科学论文、扫描表格还是多语言文档，Surya 都能提供您所需的工具，以实现准确和高效的文本提取。

