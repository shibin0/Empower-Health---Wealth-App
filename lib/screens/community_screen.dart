import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/community_service.dart';
import '../utils/app_theme.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'Community',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.primaryColor),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search feature coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppTheme.primaryColor),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications feature coming soon!')),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.lightMutedForeground,
          indicatorColor: AppTheme.primaryColor,
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Groups'),
            Tab(text: 'Challenges'),
            Tab(text: 'Feed'),
            Tab(text: 'Leaderboard'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const GroupsTab(),
          const ChallengesTab(),
          const SocialFeedTab(),
          const LeaderboardTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Create post feature coming soon!')),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class GroupsTab extends ConsumerWidget {
  const GroupsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(communityGroupsProvider((category: null, type: null)));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(communityGroupsProvider);
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Featured Groups',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 12),

            groupsAsync.when(
              data: (groups) => Column(
                children: groups.map((group) => _buildGroupCard(context, group)).toList(),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error loading groups: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, CommunityGroup group) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      group.coverImage,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                      ),
                      Text(
                        '${group.memberIds.length} members • ${group.category}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.lightMutedForeground,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(group.category).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    group.privacy,
                    style: TextStyle(
                      color: _getCategoryColor(group.category),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              group.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 12),
            
            // Group goal progress
            if (group.groupGoal.isNotEmpty) ...[
              Text(
                'Group Goal: ${group.groupGoal['target']}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: (group.groupGoal['progress'] as double),
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(_getCategoryColor(group.category)),
              ),
              const SizedBox(height: 8),
            ],

            // Tags
            Wrap(
              spacing: 6,
              children: group.tags.map((tag) => Chip(
                label: Text(tag),
                backgroundColor: Colors.grey[100],
                labelStyle: const TextStyle(fontSize: 10),
              )).toList(),
            ),
            const SizedBox(height: 12),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Joined ${group.name}!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Join Group'),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Viewing ${group.name} details')),
                    );
                  },
                  child: const Text('View'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'health':
        return AppTheme.successColor;
      case 'wealth':
        return AppTheme.primaryColor;
      default:
        return AppTheme.warningColor;
    }
  }
}

class ChallengesTab extends ConsumerWidget {
  const ChallengesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengesAsync = ref.watch(activeChallengesProvider((category: null, type: null)));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(activeChallengesProvider);
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Active Challenges',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 12),

            challengesAsync.when(
              data: (challenges) => Column(
                children: challenges.map((challenge) => _buildChallengeCard(context, challenge)).toList(),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error loading challenges: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard(BuildContext context, Challenge challenge) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getChallengeColor(challenge.category).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Icon(
                      _getChallengeIcon(challenge.category),
                      color: _getChallengeColor(challenge.category),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                      ),
                      Text(
                        '${challenge.participantIds.length} participants • ${challenge.difficulty}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.lightMutedForeground,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor(challenge.difficulty).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    challenge.type,
                    style: TextStyle(
                      color: _getDifficultyColor(challenge.difficulty),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              challenge.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 12),
            
            // Challenge goal
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.flag,
                    color: _getChallengeColor(challenge.category),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Goal: ${challenge.goal['target']} ${challenge.goal['unit']}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Joined ${challenge.title}!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getChallengeColor(challenge.category),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Join Challenge'),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Viewing ${challenge.title} details')),
                    );
                  },
                  child: const Text('Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getChallengeColor(String category) {
    switch (category) {
      case 'health':
        return AppTheme.successColor;
      case 'wealth':
        return AppTheme.primaryColor;
      default:
        return AppTheme.warningColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return AppTheme.successColor;
      case 'medium':
        return AppTheme.warningColor;
      case 'hard':
        return AppTheme.errorColor;
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData _getChallengeIcon(String category) {
    switch (category) {
      case 'health':
        return Icons.favorite;
      case 'wealth':
        return Icons.trending_up;
      default:
        return Icons.star;
    }
  }
}

class SocialFeedTab extends ConsumerWidget {
  const SocialFeedTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(socialFeedProvider((userId: null, groupId: null, type: null)));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(socialFeedProvider);
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Community Feed',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 12),

            feedAsync.when(
              data: (posts) => Column(
                children: posts.map((post) => _buildPostCard(context, post)).toList(),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error loading feed: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, SocialPost post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post header
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                  child: Text(
                    _getAuthorInitials(post.authorId),
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getAuthorName(post.authorId),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _formatPostTime(post.createdAt),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.lightMutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getPostTypeColor(post.type).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    post.type,
                    style: TextStyle(
                      color: _getPostTypeColor(post.type),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Post content
            Text(
              post.content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),

            // Post actions
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Liked post!')),
                    );
                  },
                  icon: Icon(
                    Icons.favorite_border,
                    size: 16,
                    color: AppTheme.lightMutedForeground,
                  ),
                  label: Text(
                    '${post.likes.length}',
                    style: TextStyle(color: AppTheme.lightMutedForeground),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Comment feature coming soon!')),
                    );
                  },
                  icon: Icon(
                    Icons.comment_outlined,
                    size: 16,
                    color: AppTheme.lightMutedForeground,
                  ),
                  label: Text(
                    '${post.comments.length}',
                    style: TextStyle(color: AppTheme.lightMutedForeground),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getAuthorInitials(String authorId) {
    switch (authorId) {
      case 'user1':
        return 'SJ';
      case 'user2':
        return 'MC';
      case 'user3':
        return 'ED';
      default:
        return 'U';
    }
  }

  String _getAuthorName(String authorId) {
    switch (authorId) {
      case 'user1':
        return 'Sarah Johnson';
      case 'user2':
        return 'Mike Chen';
      case 'user3':
        return 'Emma Davis';
      default:
        return 'User';
    }
  }

  String _formatPostTime(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  Color _getPostTypeColor(String type) {
    switch (type) {
      case 'achievement':
        return AppTheme.successColor;
      case 'tip':
        return AppTheme.primaryColor;
      case 'progress':
        return AppTheme.warningColor;
      case 'question':
        return AppTheme.infoColor;
      default:
        return AppTheme.primaryColor;
    }
  }
}

class LeaderboardTab extends ConsumerWidget {
  const LeaderboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardsAsync = ref.watch(leaderboardsProvider((category: null, timeframe: null)));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(leaderboardsProvider);
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Leaderboards',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 12),

            leaderboardsAsync.when(
              data: (leaderboards) => Column(
                children: leaderboards.map((leaderboard) => _buildLeaderboardCard(context, leaderboard)).toList(),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error loading leaderboards: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardCard(BuildContext context, Leaderboard leaderboard) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.leaderboard,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    leaderboard.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    leaderboard.timeframe,
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Top 3 entries
            ...leaderboard.entries.take(3).map((entry) => _buildLeaderboardEntry(context, entry)),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardEntry(BuildContext context, LeaderboardEntry entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _getRankColor(entry.rank).withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                '${entry.rank}',
                style: TextStyle(
                  color: _getRankColor(entry.rank),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            entry.avatar,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              entry.userName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '${entry.score.toInt()}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: _getRankColor(entry.rank),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return AppTheme.primaryColor;
    }
  }
}