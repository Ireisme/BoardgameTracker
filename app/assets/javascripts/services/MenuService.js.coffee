angular.module('BoardgameTracker')
.factory 'menu', [
  '$location'
  ($location) ->
    sections = [ {
      name: 'Latest Games'
      state: 'home.games.latest'
      type: 'link'
    } ]
    sections.push
      name: 'Games'
      type: 'toggle'
      icon: 'fa fa-gamepad'
      pages: [
        {
          name: 'Add'
          state: 'home.games.add'
          type: 'link'
          icon: 'fa fa-plus'
        }
        {
          name: 'List'
          type: 'link'
          state: 'home.games.all'
          icon: 'fa fa-gamepad'
        }
      ]
    sections.push
      name: 'Players'
      type: 'toggle'
      pages: [
        {
          name: 'Add'
          type: 'link'
          state: 'home.players.new'
          icon: 'fa fa-user-plus'
        }
        {
          name: 'List'
          state: 'home.players.all'
          type: 'link'
          icon: 'fa fa-users'
        }
      ]
    self = undefined
    self =
      sections: sections
      toggleSelectSection: (section) ->
        self.openedSection = if self.openedSection == section then null else section
        return
      isSectionSelected: (section) ->
        self.openedSection == section
      selectPage: (section, page) ->
        page and page.url and $location.path(page.url)
        self.currentSection = section
        self.currentPage = page
        return
]