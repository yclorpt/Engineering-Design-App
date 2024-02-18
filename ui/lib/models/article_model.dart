import 'package:equatable/equatable.dart';

class Article extends Equatable{
  final String id;
  final String title;
  final String subtitle;
  final String body;
  final String author;
  final String category;
  final String imageUrl;
  final DateTime createdAt;

  const Article({
    required this.id, 
    required this.title, 
    required this.subtitle, 
    required this.body, 
    required this.author, 
    required this.category, 
    required this.imageUrl, 
    required this.createdAt, 
    required bool breaking,
    });

    static List<Article> articles = [
      //Test articles for chris to modify - should parse from internet and create new articles(maybe)
      Article(
        id: '0',
        title: 'Studies link coffee to eeffoc? Says it''s funny',
        subtitle: 'subtitle test1',
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec ac odio tempor orci dapibus. Sollicitudin ac orci phasellus egestas tellus rutrum. Purus in massa tempor nec feugiat nisl. Justo nec ultrices dui sapien eget mi proin. Netus et malesuada fames ac turpis egestas sed tempus urna. Lorem sed risus ultricies tristique. Volutpat sed cras ornare arcu dui vivamus. Ut porttitor leo a diam sollicitudin. Sed enim ut sem viverra aliquet eget. Turpis egestas maecenas pharetra convallis posuere morbi leo urna. Arcu non sodales neque sodales ut etiam sit amet nisl. Aliquet eget sit amet tellus cras adipiscing enim eu turpis. Ornare arcu dui vivamus arcu felis bibendum. Mauris vitae ultricies leo integer malesuada. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Quisque id diam vel quam elementum pulvinar. Nunc sed blandit libero volutpat. Quam elementum pulvinar etiam non quam lacus suspendisse faucibus interdum.',
        author: 'author test1',
        category: 'Global',
        imageUrl: 'https://media.istockphoto.com/id/1406496671/photo/psychiatrist-or-professional-psychologist-counseling-or-therapy-session-to-male-patients.jpg?s=612x612&w=0&k=20&c=8hA0uzGJoMWohJWEtNUgNemRHawAR5Sw2frrEwW_ldY=',
        createdAt: DateTime.now().subtract(const Duration(hours: 19)),
        breaking: true,
      ),

      Article(
        id: '1',
        title: 'title test2',
        subtitle: 'subtitle test2',
        body: 'body test2',
        author: 'author test2',
        category: 'Local',
        imageUrl: 'https://media.istockphoto.com/id/1406496671/photo/psychiatrist-or-professional-psychologist-counseling-or-therapy-session-to-male-patients.jpg?s=612x612&w=0&k=20&c=8hA0uzGJoMWohJWEtNUgNemRHawAR5Sw2frrEwW_ldY=',
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        breaking: false,
      )
    ];
  
  @override
  List<Object?> get props => [
    id, 
    title, 
    subtitle, 
    body, 
    author, 
    category, 
    imageUrl, 
    createdAt,
  ];
}