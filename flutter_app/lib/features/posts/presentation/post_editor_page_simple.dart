import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostEditorPageSimple extends StatefulWidget {
  final int? postId;
  
  const PostEditorPageSimple({super.key, this.postId});

  @override
  State<PostEditorPageSimple> createState() => _PostEditorPageSimpleState();
}

class _PostEditorPageSimpleState extends State<PostEditorPageSimple> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String? _selectedCategory;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postId == null ? '게시물 작성' : '게시물 수정'),
        elevation: 1,
        actions: [
          TextButton(
            onPressed: _savePost,
            child: const Text('저장'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // AI 기능 준비중 안내
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.blue.shade600),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'AI 작성 도우미 기능이 준비중입니다!',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // 제목 입력
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: '제목',
                  hintText: '게시물 제목을 입력하세요',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '제목을 입력해주세요';
                  }
                  return null;
                },
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              
              // 카테고리 선택
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: '카테고리',
                  border: OutlineInputBorder(),
                ),
                hint: const Text('카테고리를 선택하세요'),
                items: const [
                  DropdownMenuItem(value: 'tech', child: Text('기술')),
                  DropdownMenuItem(value: 'life', child: Text('라이프')),
                  DropdownMenuItem(value: 'food', child: Text('음식')),
                  DropdownMenuItem(value: 'ai', child: Text('AI/ML')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return '카테고리를 선택해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // 내용 입력
              Expanded(
                child: TextFormField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    labelText: '내용',
                    hintText: '게시물 내용을 입력하세요...',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: null,
                  expands: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '내용을 입력해주세요';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('AI 챗봇 기능이 준비중입니다!')),
          );
        },
        tooltip: 'AI 도우미 (준비중)',
        child: const Icon(Icons.smart_toy),
      ),
    );
  }

  void _savePost() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('게시물이 저장되었습니다 (데모)')),
      );
      context.pop();
    }
  }
}