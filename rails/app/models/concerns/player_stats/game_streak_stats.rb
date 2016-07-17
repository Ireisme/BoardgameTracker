module PlayerStats
  module GameStreakStats
      extend ActiveSupport::Concern

      def best_streak
        sql = "
          with new_streaks as (
              select
                sp.\"placing\",
                s.played as \"played\",
                s.created_at,
              --new streak
              case when
                \"placing\" = 1 and
                lag(\"placing\") over (order by played,s.created_at) > 1
                then 1
              --no new streak
                else 0
              end new_streak
              from
                sessions s
              inner join session_players sp on s.id = sp.session_id
              inner join
              (
                select session_id, MIN(\"placing\") as min_placing
                from session_players
                group by session_id
              ) sp1 on sp1.session_id = sp.session_id and sp.\"placing\" = sp1.min_placing
              where sp.player_id = #{@player_id}
          ),
          streak_no as (
          --  Assigning a unique number to each streak.
          select
          --  In order to be able to count the number of records
          --  of a streak, we first need to assign a unique number
          --  to each streak:
              sum(new_streak) over (order by played,created_at) streak_no
          from
              new_streaks
          where
          --  We're only interested in winning streaks:
              \"placing\" = 1
          ),
          records_per_streak as (
            select
              count(*) counter,
              streak_no
            from
              streak_no
            group by
              streak_no
          )

          select
            max(counter) longest_streak
          from
            records_per_streak"
        results = ActiveRecord::Base.connection.execute(sql)
        return results.to_a.first['longest_streak'].to_i
      end
  end
end