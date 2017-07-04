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

      def current_streak
        sql = "
        SELECT
        S1.ID,
        T1.\"placing\",
        (
            SELECT 1 + COUNT(*)                 -- Earlier games with the same player
            FROM sessions S2
            inner join session_players T2 on S2.id = T2.session_id
            where ((T1.\"placing\" > 1 and T2.\"placing\" > 1) or (T1.\"placing\" = 1 and T2.\"placing\" = 1))
            and T1.player_id = T2.player_id
            AND (S1.played > S2.played OR (S1.played = S2.played AND S1.created_at > S2.created_at))
            AND NOT EXISTS (
              SELECT *                    -- The games in between, with the same player but opposite result.
              FROM sessions S3
              inner join session_players T3 on S3.id = T3.session_id
              WHERE
                  ((T2.\"placing\" > 1 and T3.\"placing\" = 1) or (T2.\"placing\" = 1 and T3.\"placing\" > 1))
                  AND T1.player_id = T3.player_id
                  AND (S3.played > S2.played OR (S2.played = S3.played AND S3.created_at > S2.created_at))
	                AND (S3.played < S1.played OR (S1.played = S3.played AND S3.created_at < S1.created_at))
            )
        ) streak
        FROM sessions S1
        --TODO get this joining
        inner join session_players T1 on T1.session_id = S1.id
        where T1.player_id = #{@player_id}
        order by S1.played desc, S1.created_at desc
        limit 1;"
        results = ActiveRecord::Base.connection.execute(sql)
        return 0 if results.num_tuples.zero?

        is_win_streak = results.to_a.first['placing'].to_i == 1
        streak_count = results.to_a.first['streak'].to_i
        return is_win_streak ? streak_count : -streak_count
      end
  end
end