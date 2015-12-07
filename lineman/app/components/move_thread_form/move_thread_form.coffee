angular.module('loomioApp').factory 'MoveThreadForm', ->
  templateUrl: 'generated/components/move_thread_form/move_thread_form.html'
  controller: ($scope, $location, discussion, CurrentUser, FormService, Records, $filter) ->
    $scope.discussion = discussion.clone()

    $scope.availableGroups = ->
      _.filter CurrentUser.groups(), (group) ->
        group.id != discussion.groupId

    $scope.submit = FormService.submit $scope, $scope.discussion,
      submitFn: $scope.discussion.move
      flashSuccess: 'move_thread_form.messages.success'
      flashOptions:
        name: -> $scope.discussion.group().name

    $scope.updateTarget = ->
      $scope.targetGroup = Records.groups.find($scope.discussion.groupId)
    $scope.updateTarget()

    $scope.moveThread = ->
      if $scope.discussion.private == true and $scope.targetGroup.privacyIsOpen()
        $scope.submit() if confirm($filter('translate')('move_thread_form.confirm_change_to_private_thread', groupName: $scope.targetGroup.name))
      else
        $scope.submit()
